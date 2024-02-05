---
title: 迷你程式計畫：blog
date: 2024-02-05T23:06:28+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
之前的迷你網站計畫改成迷你程式計畫，因為以後不一定只寫迷你網站

這一陣子在忙著把 Ruby on Rails 文件的[Getting Started with Rails](https://guides.rubyonrails.org/v7.0/getting_started.html)，改寫成 Laravel 10 版本，作為迷你程式的第一個主題。一開始只看文件，根本不知道它在做什麼，索性照著寫一遍，覺得 Rails 還真是貫徹約定優於設定，連 View 和 Helper 都有慣例，所以如果只是顯示頁面，則 Controller 的 method 可以一行程式碼都不用寫，像是：

``` ruby
class ArticlesController < ApplicationController

  # method index 一行都沒有，預設顯示 app/views/articles/index.html.erb
  def index
  end
```

寫到後面覺得 Rails 的確比 Laravel 少寫一些東西，但是內建也多了一些東西，例如 [Turbo](https://turbo.hotwired.dev/)，基本上 Rails 能做到的 Laravel 也能，改寫成 Laravel 10 版本沒有什麼問題。

