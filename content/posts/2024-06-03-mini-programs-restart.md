---
title: 迷你網站計畫：重啟
date: 2024-06-03T22:02:11+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
我一直以為要先讀完書或官方文件，才能開始寫程式，實際上根本念不完，而且等到開始寫程式，前面讀的已經忘光光了，然後開始懷疑為什麼要花那麼多時間讀書。這是迷你網站計畫一直停滯的原因之一。

之前寫 [wiki.php](/2023-04-26-wiki-php/)，需要閱讀  Laravel 6 官方文件，也是先挑選最基本的讀完就好：

- The Basics 讀完：從 Routing、Middleware 到 Logging 全部章節
- 然後 Database：Getting Started、Query Builder、Pagination、Migrations 和 Seeding
- 最後是 Eloquent ORM 的 Getting Started 和 Relationships

既然能夠做完一個 wiki.php，表示你已經不是 Laravel 小白，你不需要從頭開始讀官方文件，即使讀了也很痛苦（不知道第幾次從路由開始讀起）。你需要的只是用 Laravel 寫網站，在需要某些功能時回去讀官方文件，例如需要單元測試時，先把 Testing 的 Getting Started 和 Database Testing 讀完（因為單元測試和資料庫有關）。

迷你網站的部分，之前已經決定把 Ruby on Rails 官網的 [Getting Started with Rails](https://guides.rubyonrails.org/v7.0/getting_started.html)，改寫成 Laravel 10 版本，幾個月前就把 Rails 的版本做完了，只是照著人家的操作做一遍，之後 Laravel 10 的版本也完成了，目前在做前端改用 AJAX 的版本。結果安裝到 VM 上，發現 Server Error 500，因為只是 `composer install` 是不夠的，還有一堆指令呢，不過這次懂得把安裝過程紀錄在 README，供下次安裝使用。