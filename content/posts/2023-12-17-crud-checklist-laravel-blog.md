---
title: CRUD 網站檢查表 - 使用 Laravel (部落格)
date: 2023-12-17T20:30:57+08:00
toc: true
authors:
  - Tom
lightgallery: false
draft: false
---
## 安裝開發環境

首先參考[使用 Docker Compose 安裝 Laravel 和 Vue.js 環境](/2023-11-17-docker-for-laravel-and-vue)，安裝到 Laravel 後端。

執行 `docker compose exec backend sh`，連進後端 php 環境

## 新增 resource PostController

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

## 顯示 Posts 路由

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

## 顯示新增文章表單

用編輯器打開 `PostController`，在 method `create()` 填入以下程式碼，顯示 view `resources/views/posts/create.blade.php`

``` php
public function create()
{
    return view('posts.create');
}
```

在瀏覽器執行網址 http://127.0.0.1/posts/create ，會顯示沒有這個 view，所以新增它

``` bash
mkdir -p resources/views/posts/
```

用編輯器新增檔案 `resources/views/posts/create.blade.php`，並打開它，填入以下的程式碼

``` html
<div>
  <a href="{{ route('posts.index') }}">回到首頁</a>
</div>

<h1>New Post</h1>

<form method="post" accept-charset="utf-8" action="{{ route('posts.store') }}">
  @csrf
  
  <div>
    <label for="post_title">Title</label><br>
    <input type="text" name="post[title]" id="post_title">
  </div>
  
  <div>
    <label for="post_body">Body</label><br>
    <textarea name="post[body]" id="post_body"></textarea>
  </div>
  
  <div>
    <button type="submit">Create Post</button>
  </div>
</form>
```

- `{{ route('posts.store') }}` 呼叫 `route(路由名稱)`，產生 HTML `http://127.0.0.1/posts`
- `@csrf` ：新增、修改或刪除需要有 CSRF 欄位進行驗證才能執行，否則送出表單會顯示 419 PAGE EXPIRED
