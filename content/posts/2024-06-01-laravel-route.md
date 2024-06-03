---
title: Laravel 10 官方文件筆記：路由
date: 2024-06-01T23:10:28+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
先試著講解給部落格讀者聽，所以一邊說話，一邊打字：

``` php
Route::get('/greeting', function() {
  return 'Hello World';
});
```

`Route::get()` 接收兩個參數，URI 和 Closure，即 `function() {}`，或者是字串陣列：

``` php
use App\Http\Controllers\UserController;

Route::get('/user', [UserController::class, 'index']);
```

陣列第一個字串代表呼叫的 controller，第二個是 controller 的方法名稱，所以上述的程式碼表示當有 GET /user 請求時，呼叫 `\App\Http\Controllers\UserController.php` 的 `index()`。第一個參數可以用 字串 `\App\Http\Controllers\UserController`，不過這樣長的字串，不如用上述的 `UserController::class` 表示法更方便，因為通常 controller 不會只出現一次 

需要用以下的指令新增 UserController

``` bash
php artisan make:controller UserController
```

到這裡大約打字十分鐘，手已經累到懷疑之後都要這樣嗎？所以放棄。

---

路由設定在有無路由快取時結果不同

``` php
use App\Http\Controllers\HomeController;
// A
Route::get('/', [HomeController::class, 'get']);
Route::match(['get', 'post'], '/', [HomeController::class, 'match']);
Route::any('/', [HomeController::class, 'any']);
// B
Route::get('/', [HomeController::class, 'get']);
Route::any('/', [HomeController::class, 'any']);
Route::match(['get', 'post'], '/', [HomeController::class, 'match']);
// C
Route::any('/', [HomeController::class, 'any']);
Route::get('/', [HomeController::class, 'get']);
Route::match(['get', 'post'], '/', [HomeController::class, 'match']);
// D
Route::any('/', [HomeController::class, 'any']);
Route::match(['get', 'post'], '/', [HomeController::class, 'match']);
Route::get('/', [HomeController::class, 'get']);
```

| 路由快取 | A                | B                | C                | D              |
| ---- | ---------------- | ---------------- | ---------------- | -------------- |
| 沒有   | `Route::any()`   | `Route::match()` | `Route::match()` | `Route::get()` |
| 有    | `Route::match()` | `Route::match()` | `Route::any()`   | `Route::any()` |

官方文件說，get, post 等方法的路由應該在 any, match 方法之前定義，以確保正確的路由匹配。所以路由是由上往下匹配的嗎？以上測試的結果，沒有路由快取時，由下往上匹配；有快取時則不一定。所以最好不要用 `Route::any()` 和 `Route::match()`

``` php
// A
Route::get('/there', function() {
  return 'there';
});
Route::get('/here', function() {
  return 'here';
});
Route::redirect('/here', '/there');
// B：Route::redirect() 移到最上面
Route::redirect('/here', '/there');
Route::get('/there', function() {
  return 'there';
});
Route::get('/here', function() {
  return 'here';
});
```

`GET /here` 時，有無路由快取結果也不同：

| 路由快取 | A        | B        | 路由匹配 |
| ---- | -------- | -------- | ---- |
| 沒有   | 顯示 there | 顯示 here  | 由下往上 |
| 有    | 顯示 here  | 顯示 there | 由上往下 |

另外重新導向並不是用 HTML 的 `<meta http-equiv="refresh" content="0; url=http://127.0.0.1:8000/">`，這點和 Laravel 6 不同。

突然意識到，就算全部讀完，結果是前面讀完的全忘光了，而且其實路由我已經看了好幾遍了。之前已經做了一個 Laravel 網站 [wiki.php](/2023-04-26-wiki-php/)，應該不用像新手一樣從頭開始讀官方文件吧？