https://www.jianshu.com/p/b527dc3427fa

修改 `vite.config.js`

``` js
export default defineConfig({
    plugins: [
        // ...省略
        ],
    // 加上以下内容
    server: {
        host: '0.0.0.0'
    }
})
```

這樣執行 `npm run dev` 後，會看到類似以下的結果

```
 VITE v5.0.10  ready in 566 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: http://10.0.2.15:5173/
  ➜  Network: http://192.168.56.10:5173/
  ➜  press h + enter to show help

  LARAVEL v10.39.0  plugin v1.0.1

  ➜  APP_URL: http://localhost
```

瀏覽 http://192.168.56.10:5173/ 就能正常存取了
