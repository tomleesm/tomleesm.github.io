---
title: 迷你網站計畫：反覆做同一個主題
date: 2023-11-12T22:48:46+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
如果我是陶藝課程第二組的學生，我會做一百個杯子，而不是杯子、碗、盤子等總共二十個不同的器具。

一開始我還是用以前的經驗，每個專案都是新的主題，用這樣的方式寫專案，需要很多主題，難度還要循序漸進，太麻煩了。不如用同一個主題，就像每次都做杯子，這樣只要一個主題，每次從頭開始寫同樣的程式，這樣會怎樣呢？我不知道，真的不知道，這是一段全新的未知旅程。

覺得待辦事項網站最適合，看起來簡單，但是該練習到的東西都有。例如通知使用者安排的時間到了，會用到 WebSocket，這樣就不需要硬是做一個聊天室網站。另外我對於目前市面上的待辦事項網站不是很滿意，所以就自己做。

各個版本的待辦事項網站目標：

1. 只用 Laravel 10
2. jQuery 做前端，Laravel 做後端，程式放在同一個目錄
3. 承上，前後端分開在不同的目錄，使用 RESTful API 溝通前後端
4. 後端用測試驅動開發的方式完成
5. 前端用測試驅動開發的方式完成
6. 參考 Amazon 逆向工作法，先完成新聞稿、常見問題、使用手冊和 Swagger API 文件，再寫程式
7. 用 Bootstrap 美化介面