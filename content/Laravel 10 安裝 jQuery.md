> 沒辦法用 `npm run dev` 持續更新 js 檔。
> 如果要用 jQuery，建議回去用 [Mix](https://laravel-mix.com/)。請閱讀官方提供的文件 [Migrating from Vite to Laravel Mix](https://github.com/laravel/vite-plugin/blob/0.x/UPGRADE.md#migrating-from-vite-to-laravel-mix)

https://techvblogs.com/blog/how-to-install-jquery-in-laravel-10

# Laravel Vite 使用 NPM 新增 JQuery

新增 jQuery 套件

``` bash
npm install jquery
# 或者
yarn add jquery
```

匯入 jQuery。修改 `resources/js/bootstrap.js`，加入以下這兩行，也就是新增 `resolve: {...}` 的部分

``` js
import jQuery from 'jquery';
window.$ = jQuery;
```

在 Vite 設定檔中包含 `$` 符號。修改 `vite.config.js`，改成以下這樣

``` js
import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
  
export default defineConfig({
    plugins: [
        laravel({
            input: [
                'resources/sass/app.scss',
                'resources/js/app.js',
            ],
            refresh: true,
        }),
    ],
    resolve: {
        alias: {
            '$': 'jQuery'
        },
    },
});
```

建立 npm JavaScript 和 CSS 文件，執行以下指令。  
這是把 javascript 轉成 production 程式碼。沒辦法用 `npm run dev` 持續更新 js 檔

``` bash
npm run build
```

使用 `app.blade.php` 做為首頁。修改 `routes/web.php`

``` php
Route::view('/', 'app');
```

修改 `resources/views/app.blade.php`

``` php
<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  
    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
  
    <title>{{ config('app.name', 'Laravel') }}</title>
    
    <!-- Scripts -->
    @vite(['resources/js/app.js'])
  
    <script type="module">
        $("button").click(function(){
            alert("jQuery work!");
        });
    </script>
  
</head>
<body>
    <div id="app">
  
        <main class="container">
            <h1> How to Install JQuery in Laravel 10? - TechvBlogs.com</h1>
              
            <button class="btn btn-success">Click Me</button>
        </main>
    </div>
  
</body>
</html>
```

執行 Laravel 應用程式。執行以下指令，或者設定 nginx

``` bash
php artisan serve
```

## Laravel 10 安裝 jQuery with docker

以下內容承襲自[[使用 Docker Compose 安裝 Laravel 和 Vue.js 環境]]

`docker-compose.yaml` 除了 blog 文章原來的設定，volumes 改用後端檔案

frontend 的 `volumes: - ./src/backend:/var/www/frontend`

不新增 Vue.js 專案 tmp 和不安裝 Vue.js 依賴的套件，改成安裝 jquery

``` bash
docker compose run --rm frontend yarn add jquery
docker compose run --rm frontend yarn add @rollup/plugin-inject --dev
```

`frontend.conf` 檔案不用新增，`backend.conf` 和 `docker-compose.yaml` 不用改 port 8000

在 `src/frontend` 新增 `vite.config.js` 檔案，不執行，改成修改 `src/backend/vite.config.js`，新增前面有 `+` 符合的

``` javascript
export default defineConfig({
    plugins: [
        laravel({
+           $: 'jquery',
+           jQuery: 'jquery',
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
    ],                                                                                                                                                        
});

`src/backend/resources/js/bootstrap.js` 改成以下這樣，注意 import 要放在檔案開頭

``` javascript
import $ from 'jquery';
window.$ = $;
```

