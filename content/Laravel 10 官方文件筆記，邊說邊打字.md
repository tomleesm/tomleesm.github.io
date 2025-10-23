---
title: Laravel 10 官方文件筆記，邊說邊打字
date: 2024-06-01
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
