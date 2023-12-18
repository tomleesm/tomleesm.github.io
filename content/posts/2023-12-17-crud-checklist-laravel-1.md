---
title: CRUD 網站檢查表 - 使用 Laravel (一)
date: 2023-12-17T20:30:57+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
首先參考[使用 Docker Compose 安裝 Laravel 和 Vue.js 環境](/2023-11-17-docker-for-laravel-and-vue)，安裝到 Laravel 後端。

執行 `docker compose exec backend sh`，連進後端 php 環境

新增 resource controller `PostController`，檔案是 `app\Http\Controllers\PostController.php`

``` bash
php artisan make:controller PostController  --resource
```

開另一個終端機，在 host 端切換到 `src/backend` 目錄，在 `routes/web.php` 新增一個 `resource` 路由。刪除預設的 `Route::get('/')` 歡迎頁面那三行

``` php
use App\Http\Controllers\PostController;

Route::resource('posts', PostController::class);
```

把 `routes/api.php` 內的路由註解起來，這個程式沒有用到 API

執行 `php artisan route:list --except-vendor` 指令(不顯示 Laravel 外掛需要的路由)

會有以下路由（為了 markdown 格式和美觀調整過）

| HTTP 動詞 | 網址 | 路由名稱 | controller@method |
| ---------- | ----- | ---------- | ------------------ |
| GET/HEAD | posts | posts.index | PostController@index |
| POST | posts | posts.store | PostController@store |
| GET/HEAD | posts/create | posts.create | PostController@create |
| GET/HEAD | posts/{post} | posts.show | PostController@show |
| PUT/PATCH | posts/{post} | posts.update | PostController@update |
| DELETE | posts/{post} | posts.destroy | PostController@destroy |
| GET/HEAD | posts/{post}/edit | posts.edit | PostController@edit |

接下來就只是把上面這個表格的功能和頁面(view)做出來