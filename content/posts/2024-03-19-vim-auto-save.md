---
title: Vim 自動存檔
date: 2024-03-19T02:17:41+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: true
---
最近寫程式時想要像 VS Code 那樣自動存檔，並且只有特定檔案類型才存檔，例如 PHP 檔，Google 後發現其實沒那麼簡單。
<!--more-->
## 使用外掛

外掛 [vim-auto-save](https://github.com/907th/vim-auto-save)需要在 .vimrc 中設定 `let g:auto_save = 1` 才能啟用自動存檔，但是這樣會讓所有檔案都存檔。雖然可以用 `au FileType php let b:auto_save = 1` 設定 php 檔案才存檔，但是這樣會把 .vimrc 弄的很複雜，因為檔案類型很多，我想要用 ftplugin 的方式，但是無法使用 `let b:auto_save = 1`

## 改用內建指令

## blade 檔案怎麼辦？