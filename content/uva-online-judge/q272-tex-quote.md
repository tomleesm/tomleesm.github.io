---
title: "Q272 TeX Quotes"
date: 2023-08-07T10:07:30+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
```
"To be or not to be," quoth the Bard, "that
is the question".
The programming contestant replied: "I must disagree.
To `C' or not to `C', that is The Question!"
```

輸入若干列文字(所以用 `input()` 會有問題)，...以 end-of-file 做結束(所以會讀取檔案)...  

```
把每一個字元抓出來
if 字元是雙引號
    if 第一個雙引號
        把雙引號換成兩個 ` 字元
    else
        把雙引號換成 2 個單引號
else
    字元存到字串的尾端 (result )

print(result)
```

STUCK：怎麼知道是第一個雙引號，還是第二個？  
AHA：用一個變數紀錄 `first_double_quote = True`

``` python
if first_double_quote
    # 把雙引號換成 ` 字元
    first_double_quote = False
else:
    # 把雙引號換成兩個單引號
    first_double_quote = True
```

最後結果

``` python
# 讀取檔案為字串
f = open("Q272_input.txt", "rt")
first_double_quote = True
result = ""

for line in f:
    # 把每一個字元抓出來
    for s in line:
        # if 字元是雙引號
        if s == '"':
            # 第一個雙引號
            if first_double_quote:
                # 把雙引號換成兩個 `` 字元
                result += "``"
                first_double_quote = False
            # 第二個雙引號
            else:
                # 把雙引號換成兩個單引號
                result += "''"
                first_double_quote = True
        # 不是雙引號
        else:
            # 字元存到字串尾端
            result += s

f.close()
print(result)
```

Q272_input.txt

```
"To be or not to be," quoth the Bard, "that
is the question".
The programming contestant replied: "I must disagree.
To `C' or not to `C', that is The Question!"
```