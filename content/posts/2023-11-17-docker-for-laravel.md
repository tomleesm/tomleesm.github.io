---
title: 使用 Docker Compose 建立 Laravel 環境
date: 2023-11-17T14:59:47+08:00
toc: true
authors:
  - Tom
lightgallery: false
draft: false
---

想要用 Docker 建立 Laravel 環境，於是 (Google "Docker LEMP")[https://www.google.com/search?q=Docker+LEMP&oq=Docker+LEMP]，發現一篇很棒的文章[Docker for local web development, introduction: why should you care?](https://tech.osteel.me/posts/docker-for-local-web-development-introduction-why-should-you-care)。因為不想每次忘記指令都回去看這一系列文章（英文沒那麼好），於是寫筆記。

## 安裝 Docker

### 安裝指令

首先安裝 Docker，依照官方文件安裝即可，預設安裝 Docker 和 Docker Compose

- Windows：參考[Install Docker Desktop on Windows](https://docs.docker.com/desktop/windows/install/)。WSL 是系統核心 API 轉譯的方式執行(參考[介紹好用工具：WSL (Windows Subsystem for Linux)](https://blog.miniasp.com/post/2019/02/01/Useful-tool-WSL-Windows-Subsystem-for-Linux))，Hyper-V 則是微軟自家的虛擬化技術，所以保守的安裝方式是選擇 Hyper-V backend and Windows containers，以免之後可能有一些奇怪的小問題，或是自己用 VirtualBox 或 VMWare 建立一個 Linux 環境，然後在裡面安裝 Docker
- Linux：參考[Install Docker Engine on Debian](https://docs.docker.com/engine/install/debian/)或選擇對應的發行套件

### 不用 sudo

docker 預設使用 root 執行，其他使用者必須用 sudo，所以用以下指令讓一般使用者也能用 docker

新增 docker 群組

``` bash
sudo groupadd docker
```

把目前登入的使用者（`$USER`）加入 docker 群組

``` bash
sudo usermod -aG docker $USER
```

重新登入，使得上面的指令生效，或者執行以下指令

``` bash
newgrp docker
```

如果上述方法無效，就重新啟動電腦

## 使用的指令簡介

依照 `docker-compose.yaml` 的設定新增並啟動容器，`-d` 參數表示在背景執行

``` bash
docker compose up -d
```

停止並刪除 docker compose 產生的容器和 volume（參數 `-v`）

``` bash
docker compose down -v
```

停止並刪除 docker compose 產生的容器、volume 和 image，自動略過仍被使用的 image

``` bash
docker compose down -v --rmi all --remove-orphans
```

顯示 `docker-compose.yaml` 相關的容器狀態(運作中、停止中)，`-a` 參數表示顯示包含停止中的容器

``` bash
docker compose ps -a
```

停止所有容器運作

``` bash
docker compose stop
```

要求 docker compose 在 php 容器上執行 bash，用來登入容器，登入後預設目錄是 docker 設定的 working_directory。指令 `exit` 離開容器

``` bash
docker compose exec php bash
```

顯示 nginx 容器的紀錄，如果省略 nginx 則顯示所有容器的紀錄。`-f` 代表持續監聽紀錄，按下 `Ctrl + C` 停止監聽

``` bash
docker compose logs -f nginx
```

新增 backend 容器並執行指令 `php -m` 後，刪除容器。`php -m` 指令顯示目前安裝的 php extension

``` bash
docker compose run --rm backend php -m
```
## 基本的 LEMP 環境

### Nginx

在專案目錄新增 `docker-compose.yml`，填入以下的設定

``` yaml
version: '3.8'

# Services
services:

  # Nginx Service
  nginx:
    # 使用 nginx 1.21 alpine 版本
    image: nginx:1.21-alpine
    # 本機的 port : 容器的 port
    ports:
      - 80:80
```

執行 `docker compose up -d` 後，等待下載並新增容器後，用瀏覽器打開 http://localhost ，應該會看到 nginx 歡迎畫面

### PHP

`docker-compose.yaml` 更新如下

``` yaml
version: '3.8'

# Services
services:

  # Nginx Service
  nginx:
    image: nginx:1.21-alpine
    ports:
      - 80:80
    volumes:
      - ./src:/var/www/php
      - ./.docker/nginx/conf.d:/etc/nginx/conf.d
    depends_on:
      - php

  # PHP Service
  php:
    image: php:8.1-fpm
    working_dir: /var/www/php
    volumes:
      - ./src:/var/www/php
```

`volumes` 用來同步本機和容器內的目錄與檔案，所以 `./src:/var/www/php` 表示本機端的 `./src` 目錄同步資料到容器內的 `/var/www/php` 目錄，src 目錄慣例用來放置應用程式原始碼

`depends_on` 確保 php-fpm 容器先成功新增，再來新增 nginx 容器，以免 nginx 容器回報找不到設定檔

新增目錄 `src` 和 `.docker/nginx/conf.d`。一般把 docker 設定放在 `.docker` 目錄內

``` bash
mkdir -p src .docker/nginx/conf.d
```

nginx 預設自動啟用 `/etc/nginx/conf.d` 目錄下所有副檔名為 conf 的設定檔，所以在本機端的 `.docker/nginx/conf.d` 目錄新增 `php.conf` 檔案，並填入 nginx 虛擬主機設定如下，讓 nginx 把 php 檔的請求轉給 php-fpm 處理。

```
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root   /var/www/php;
    index  index.php;

    location ~* \.php$ {
        fastcgi_pass   php:9000;
        include        fastcgi_params;
        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param  SCRIPT_NAME     $fastcgi_script_name;
    }
}
```

注意以上的 `fastcgi_pass   php:9000;` 設定，docker compose 自動建立內部網路並設定所有容器的 `/etc/hosts` 檔案，所以可以用 php 代表容器內部 ip，就像用 `localhost` 代表 `127.0.0.1`。

執行 `docker compose down` 停止並刪除之前的 nginx 容器，執行 `docker compose up -d` 新增並啟動容器。執行 `docker compose logs` 顯示紀錄檢查一下是否有錯誤，在 `src` 目錄新增 `index.php`，輸入程式碼如下

``` php
<?php
phpinfo();
```

然後在瀏覽器打開 http://localhost/ 應該會看到熟悉的 php 設定頁面

### MySQL

`docker-compose.yaml` 修改成如下

``` yaml
version: '3.8'

# Services
services:

  # Nginx Service
  nginx:
    image: nginx:1.21-alpine
    ports:
      - 80:80
    volumes:
      - ./src:/var/www/php
      - ./.docker/nginx/conf.d:/etc/nginx/conf.d
    depends_on:
      - php

  # PHP Service
  php:
    build: ./.docker/php
    working_dir: /var/www/php
    volumes:
      - ./src:/var/www/php
    depends_on:
      mysql:
        condition: service_healthy

  # MySQL Service
  mysql:
    image: mysql/mysql-server:8.0
    environment:
      # 設定使用 .env 的 MYSQL_ROOT_PASSWORD 值做為密碼
      MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD
      MYSQL_ROOT_HOST: "%"
      MYSQL_DATABASE: demo
    volumes:
      - ./.docker/mysql/my.cnf:/etc/mysql/my.cnf
      - mysqldata:/var/lib/mysql
    # 開放本機端的 port 3306 來查詢 MySQL
    ports:
      - 127.0.0.1:3306:3306
    healthcheck:
      test: mysqladmin ping -h 127.0.0.1 -u root --password=$$MYSQL_ROOT_PASSWORD
      interval: 5s
      retries: 10

# Volumes
volumes:

  mysqldata:
```

需要 `pdo_mysql` extension 讓 PHP 查詢 MySQL，php-fpm 官方 image 沒有內建，但是有 `docker-php-ext-install` 指令來安裝 php 的 extension，所以 php 改用 `Dockerfile` 建立自訂的 docker image

新增目錄 `.docker/php`
``` bash
mkdir -p .docker/php
```

然後新增 Dockerfile 檔案到 `.docker/php` 目錄，填入以下設定

```
FROM php:8.1-fpm-alpine

RUN docker-php-ext-install pdo_mysql
```

新增目錄 `.docker/mysql/`

``` bash
mkdir -p .docker/mysql/
```

在 `docker/mysql/` 內新增檔案 `my.cnf`，並填入以下設定

```
[mysqld]
collation-server     = utf8mb4_unicode_ci
character-set-server = utf8mb4
```

新增檔案 `.env`，設定 MySQL root 密碼

```
MYSQL_ROOT_PASSWORD='密碼'
```

## 前端 Vue.js 與後端 Laravel

### 後端 Laravel

#### 建立所需的 image 和權限

如果從前面的設定一路到此，需要刪除 `.docker/php` 目錄，以及檔案 `.docker/nginx/conf.d/php.conf` 和 `src/index.php`，目錄結構應該從以下那樣開始

```
├── .docker/
│   ├── mysql/
│   │   └── my.cnf
│   └── nginx/
│       └── conf.d/
├── src/
├── .env
└── docker-compose.yml
```

修改 `docker-compose.yaml` 如下
``` yaml
version: '3.8'

# Services
services:

  # Nginx Service
  nginx:
    image: nginx:1.21-alpine
    ports:
      - 80:80
    volumes:
      - ./src/backend:/var/www/backend
      - ./.docker/nginx/conf.d:/etc/nginx/conf.d
    depends_on:
      - backend

  # Backend Service
  backend:
    build:
      context: ./src/backend
      args:
        HOST_UID: $HOST_UID
    working_dir: /var/www/backend
    volumes:
      - ./src/backend:/var/www/backend
    depends_on:
      mysql:
        condition: service_healthy

  # MySQL Service
  mysql:
    image: mysql/mysql-server:8.0
    environment:
      # 設定使用 .env 的 MYSQL_ROOT_PASSWORD 值做為密碼
      MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD
      MYSQL_ROOT_HOST: "%"
      MYSQL_DATABASE: demo
    volumes:
      - ./.docker/mysql/my.cnf:/etc/mysql/my.cnf
      - mysqldata:/var/lib/mysql
    # 開放本機端的 port 3306 來查詢 MySQL
    ports:
      - 127.0.0.1:3306:3306
    healthcheck:
      test: mysqladmin ping -h 127.0.0.1 -u root --password=$$MYSQL_ROOT_PASSWORD
      interval: 5s
      retries: 10

# Volumes
volumes:
  mysqldata:
```

和 MySQL 比較，修改的地方有

- nginx 的 `volumes`：`- ./src:/var/www/php` 改為 `- ./src/backend:/var/www/backend`
- nginx 的 `depends_on`：`php` 改成 `backend`
- php 整個改成 backend

在 `.docker/nginx/conf.d` 目錄新增檔案 `backend.conf`，填入以下內容

```
server {
    listen      80;
    listen      [::]:80;
    root        /var/www/backend/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass  backend:9000;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include       fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
```

新增 `src/backend` 目錄

``` bash
mkdir -p src/backend
```

在 `src/backend` 目錄內新增 `Dockerfile`，並填入以下內容

``` yaml
FROM php:8.1-fpm-alpine

# Install extensions
RUN docker-php-ext-install pdo_mysql bcmath

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Create user based on provided user ID
ARG HOST_UID
RUN adduser --disabled-password --gecos "" --uid $HOST_UID demo

# Switch to that user
USER demo
```

使用 [multi-stage build](https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds) 方式直接複製檔案來安裝 Composer

`Dockerfile` 新增使用者 demo，並切換到 demo，這是為了讓之後新增的 Laravel 檔案權限是一般使用者，否則預設是 root。

執行以下的指令，顯示目前本機的使用者 uid

``` bash
id -u
```

然後在 `.env` 中設定環境變數

```
# 假設 id -u 的結果是 1000
HOST_UID=1000
```

最後執行 `docker compose build backend` 建立 image

#### 新增 Laravel 專案

新增 Laravel 專案 tmp，然後把 tmp 目錄內的檔案移出來，這樣 `src/backend/` 目錄內才會是 Laravel 檔案

``` bash
docker compose run --rm backend composer create-project --prefer-dist laravel/laravel tmp "10.*"

docker compose run --rm backend sh -c "mv -n tmp/.* ./ && mv tmp/* ./ && rm -Rf tmp"
```

修改 `src/backend/` 目錄的 `.env` 檔案，讓資料庫設定正確

```
DB_CONNECTION=mysql
# 不是用 127.0.0.1
DB_HOST=mysql
DB_PORT=3306
# 因為 docker compose 的 MYSQL_DATABASE 設定是 demo
DB_DATABASE=demo
DB_USERNAME=root
# .env 和 src/backend/.env 的 MYSQL_ROOT_PASSWORD 設定值要一樣
DB_PASSWORD=密碼
```

執行指令 `docker compose exec backend php artisan migrate` 確認資料庫設定正確

#### OPcache

在 `src/backend` 目錄新增 `.docker` 目錄

``` bash
mkdir -p src/backend/.docker
```

在 `src/backend/.docker` 新增 `php.ini` 檔案，填入以下內容

```
[opcache]
opcache.enable=1
opcache.revalidate_freq=0
opcache.validate_timestamps=1
opcache.max_accelerated_files=10000
opcache.memory_consumption=192
opcache.max_wasted_percentage=10
opcache.interned_strings_buffer=16
opcache.fast_shutdown=1
```

修改 `src/backend` 目錄內的 `Dockerfile` 如下

```
FROM php:8.1-fpm-alpine

# Install extensions
RUN docker-php-ext-install pdo_mysql bcmath opcache

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Configure PHP
COPY .docker/php.ini $PHP_INI_DIR/conf.d/opcache.ini

# Use the default development or production configuration
ARG APP_ENV
RUN mv $PHP_INI_DIR/php.ini-$APP_ENV $PHP_INI_DIR/php.ini

# Create user based on provided user ID
ARG HOST_UID
RUN adduser --disabled-password --gecos "" --uid $HOST_UID demo

# Switch to that user
USER demo
```

`docker-compose.yaml` 需要設定 args APP_ENV

``` yaml
backend:
    build:
      context: ./src/backend
      args:
        HOST_UID: $HOST_UID
        APP_ENV: $APP_ENV
```

設定 `.env` 
```
# development 或是 production
APP_ENV='development'
```

最後執行 `docker compose build backend` 建立 image，`docker compose up -d` 新增並啟動容器

執行 `docker compose exec backend php -m` 確認有啟用 `Zend OPcache`

### 前端 Vue.js