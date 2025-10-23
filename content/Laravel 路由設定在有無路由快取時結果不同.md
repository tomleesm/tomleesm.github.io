---
title: Laravel 路由設定在有無路由快取時結果不同
date: 2024-06-01
---

路由設定在有無路由快取時結果不同。已在 Laravel 10 和 11 測試過，有相同結果

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

`GET /here` 時，有無路由快取結果也不同。已在 Laravel 10 和 11 測試過，有相同結果

| 路由快取 | A        | B        | 路由匹配 |
| ---- | -------- | -------- | ---- |
| 沒有   | 顯示 there | 顯示 here  | 由下往上 |
| 有    | 顯示 here  | 顯示 there | 由上往下 |

另外重新導向並不是用 HTML 的 `<meta http-equiv="refresh" content="0; url=http://127.0.0.1:8000/">`，這點和 Laravel 6 不同。
