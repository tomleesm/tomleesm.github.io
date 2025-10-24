---
title: Fibonacci 數列快取版本
date: 2024-11-05
---

本來以為第一次就寫好了，結果發現在 function 外面的 `$cache` 需要在 function 裡面加上 `global $cache` 才會存取，其他程式碼都不用改。(以下是之後 Google 改用 static 的版本)
``` php
<?php
function fib(int $n): int {
	static $cache = [];
	if ($n == 1 or $n == 2 ) {
            return 1;
	}
	if (isset($cache[$n])) {
	    return $cache[$n];
	} else {
            $cache[$n] = $result = fib( $n - 1 ) + fib( $n - 2 );
	    return $result;
	}
}

printf("fib 1: %d\n", fib(1));
printf("fib 2: %d\n", fib(2));
printf("fib 3: %d\n", fib(3));
printf("fib 4: %d\n", fib(4));
printf("fib 5: %d\n", fib(5));
printf("fib 10: %d\n", fib(10));
printf("fib 20: %d\n", fib(20));
printf("fib 30: %d\n", fib(30));
printf("fib 40: %d\n", fib(40));
printf("fib 50: %d\n", fib(50));
```
