---
title: 在 Dedian 安裝 LEMP 開發環境跑 Laravel 10
date: 2023-12-26T08:16:11+08:00
toc: true
authors:
  - Tom
lightgallery: false
draft: false
---
## 摘要

這個是在 VirtualBox 6 新增虛擬機器，裝好 Debian 12 後，安裝 LEMP 的過程，最後安裝 Laravel 10 來寫網站後端

## 安裝 PHP-FPM 8.3

``` bash
sudo apt -y install lsb-release apt-transport-https ca-certificates wget gnupg
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt update; sudo apt upgrade -y

sudo apt install php8.3-{cli,fpm,pdo,gd,mbstring,curl,bcmath,opcache}
```

## 設定 PHP-FPM

``` bash
# 備份 php-fpm 池設定
sudo cp /etc/php/8.3/fpm/pool.d/www.conf /etc/php/8.3/fpm/pool.d/www.conf.sample
sudo vim /etc/php/8.3/fpm/pool.d/www.conf
```

改成以下的設定

``` bash
user = tom
group = tom
listen = 127.0.0.1:9000
listen.allowed_clients = 127.0.0.1
slowlog = /home/tom/apps/logs/slow.log
request_slowlog_timeout = 5s
```

新增上述設定需要的目錄和權限，然後重新啟動 PHP-FPM

``` bash
mkdir -p /home/tom/apps/logs/
sudo chown -R tom:tom /home/tom/apps/logs/
sudo service php8.3-fpm restart
```

## 安裝 nginx