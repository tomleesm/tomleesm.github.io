+++ 
draft = false
date = 2025-07-15T14:59:27+08:00
title = "用 docker compose 安裝與執行 VitePress"
description = ""
slug = "install-vitepress-docker"
authors = []
tags = []
categories = []
externalLink = ""
series = []
+++
## 簡介

[VitePress](https://vitepress.dev/) 是一種靜態網站產生器，類似 Git Book 那樣的東西，我用它來寫讀書筆記。官方文件只有用已經裝好 Node.js 的 VitePress 安裝方式，沒有用 docker 安裝的說明，Google 搜尋半天也找不到，好不容易自己試出了可以用的方式，所以記錄在這裡。

## VitePress image

新增檔案 Dockerfile 內容如下

```
FROM node:22-alpine
RUN yarn add global vitepress
```

docker 一般把程式用 root 全域安裝，一般網路上找到的方法是設定 `packages.json`，然後用指令 `npm install` 安裝，這樣檔案容易有權限問題(`packages.json` 變成 `root:root` )。當然可以換成 `npm add -g vitepress`，用 yarn 只是因為安裝的比較快。


``` bash
docker build . -t vitepress:latest
```

執行上述指令後，建立 vitepress:latest image。

## 載入需要的檔案和設定

新增檔案 `docker-compose.yaml` 內容如下

``` yaml
services:
  book_notes:
    image: vitepress:latest
    container_name: book_notes
    volumes:
      - ./:/app
    working_dir: /app
    command: "/node_modules/vitepress/bin/vitepress.js dev --host 0.0.0.0"
    restart: "no"
    ports:
      - "5173:5173"
```

用 docker compose 在載入容器後載入需要的檔案和設定，所以不是在 Dockerfile 設定：

- `image: vitepress:latest`： 需要確認先建立 vitepress:latest image
- `container_name: book_notes`：容器名稱統一為 book_notes，方便在其他目錄中啟動、停止或重新啟動容器
- `volumes`：匯入目前目錄下的所有檔案。目錄 src 和 .vitepress 放在根目錄
- command：載入容器和檔案後，執行指令 `vitepress dev --host 0.0.0.0` 預覽結果。`vitepress preview` 好像不能用了？
- vitepress 安裝在根目錄 /node_modules/，所以執行 `/node_modules/vitepress/bin/vitepress.js dev --host 0.0.0.0`
- 設定 `--host 0.0.0.0` 和 `ports`，才能在容器外使用 http://127.0.0.1:5173 連線
- `.vitepress/config.mjs` 的 srcDir: 'src'：設定 markdown 檔案放在 src 目錄，不是在指令中設定

最後執行 `docker compose up -d`，應該能用瀏覽器連到  http://127.0.0.1:5173

