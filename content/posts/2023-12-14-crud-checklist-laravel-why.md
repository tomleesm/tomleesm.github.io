---
title: CRUD 網站檢查表 - 使用 Laravel（為什麼要弄檢查表？）
date: 2023-12-14T19:41:55+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
- 想要很快把事情做完？而且不出錯？使用檢查表
- 寫程式很複雜，想要把它弄的簡單，容易駕馭？使用檢查表

所謂的檢查表，其實很簡單，就只是一邊做、一邊記下做了什麼。例如食譜，一邊做菜、一邊記下剛剛是清洗、切菜還是下鍋油炸。日劇 Grand Maison Tokyo，開發新菜時，需要在牆上記下步驟、加了什麼食材、加了多少，失敗了就劃掉，直到成功為止。

安裝開發環境很無聊，而且常常卡住不知道怎麼辦，我們程式設計師笑說那是測試人品好壞的時刻，於是一邊安裝、一邊記錄安裝的指令，新增修改的檔案名稱與內容。之後進一步用程式自動完成安裝步驟，也就是 [Ansible](https://zh.wikipedia.org/zh-tw/Ansible_(%E8%BB%9F%E9%AB%94)), [Terraform](https://en.wikipedia.org/wiki/Terraform_(software)), [Puppet](https://zh.wikipedia.org/wiki/Puppet), [Chef](https://zh.wikipedia.org/wiki/Chef), 和 [Salt](https://en.wikipedia.org/wiki/Salt_(software)) 這些工具。一開始安裝要用到二、三天，記下步驟後，下次複製貼上執行指令只要一小時，最後用 Ansible 之類的程式自動執行只要五分鐘，沒有比這更快了。

所以我就在想，安裝開發環境很複雜，為了控制複雜，想要把它弄的簡單，容易駕馭，減少出錯，於是記下過程，為什麼寫程式不這樣呢？之前寫完[使用 Docker Compose 安裝 Laravel 和 Vue.js 環境](/2023-11-17-docker-for-laravel-and-vue)，想到了這一點。可以寫文章記錄整個安裝過程，之後自己有需要時直接拿來用，寫網站也一樣吧？記下自己建立一個 CRUD 網站的所有步驟，寫成部落格文章，之後只要照著做就能在幾個小時內產生基本的網站程式碼(80% 的工作)，集中精力在需要特別處理的部分(20% 的工作)，例如額外的功能。

而且檢查表可以不斷累加，更新成更好的設計。例如有單元測試和沒有之間會有多大變化？如果有記錄步驟，就能清楚比較，並用在新的程式上。