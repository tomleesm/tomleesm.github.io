---
title: Q494 Kindergarten Counting Game
date: 2023-10-31T12:38:40+08:00
toc: true
authors:
  - Tom
lightgallery: false
draft: false
---
## 亂七八糟的開始

> 一開始急著解答，所以寫的亂七八糟，沒什麼用。寫出來是為了呈現真實的情況：寫程式的過程並不是都那麼順遂的

Meep Meep! 2  
I tot I taw a putty tat. 7  
I did! I did! I did taw a putty tat. 10  
Shssssssssssh ... I am hunting wabbits. Heh Heh Heh Heh ... 9  

Meep

M: 開始連續的英文字母  
p: 停止連續的英文字母

1. 把一行字串的每一個字串抓出來
2. M 是在 A ~ Z 或 a ~ z 嗎？(正規表示法？)  
  if yes, 連續英文字母 = True  
  e if yes, 連續英文字母 = True  
  e if yes, 連續英文字母 = True  
  p if yes, 連續英文字母 = True  
  (空白) else 連續英文字母 = False  
從 yes --> No, word 數 +1    

~~一開始，連續英文字母 = False~~  
~~把一行字串的每一個字元抓出來~~  
~~if 字元在 A ~ Z 或 a ~ z 之間~~  
  ~~連續英文字母 = True~~  

``` python
line_str = input()
word_start == False
for s in line_str
    if s 在 A ~ z, a ~ z 之間
        word_start = True # 開始一個新的字(word)
```

AHA: 所以有四種情況

|  | 原來的 word_start = True | 原來的 word_start = False |
| -- | --- | --- |
| s A ~ Z, a ~ z True | | |
| s A ~ Z, a ~ z False | | |

## 有耐心的特殊化

> 從這裡開始，有耐心的特殊化，就好多了

一開始, word 數 = 0

| 字元 | word_start | 字元是英文字母 | word 數 | |
| -- | --------- | ------------------ | ---- | -- |
| M | ✓ | <-- ✓ | 0 | |
| e | ✓ | <-- ✓ | 0 | |
| e | ✓ | <-- ✓ | 0 | (1) |
| p | ✓ | <-- ✓ | 0 | |
| (空白) | x | <-- x | 1 | (2) |
| M | ✓ | <-- ✓ | 1 | (3) |

``` python
if word_start == True and not (s 是英文字母)
    word_count += 1
    word_start = False

if word_start == False and s 是英文字母
    word_start = True
```

----------

``` python
word_start = False
word 數 = 0
for s in 一行字串
    if word_start:
        if s 是英文字母
            # (1)
        else:
            # (2)
            word 數 += 1
            word_start = False
    else:
        if s 是英文字母:
            # (3)
            word_start = True
        else:
            # (4) <-- 字元是 ! 或 .

print(word_count)
```

把上面的 code 包在 while True 內，for 迴圈跑完, `word_start = False, word_count = 0`

STUCK: 如果結尾沒有標點符號，會少算一個 word

例如 This is a test  
顯示為 3，正確值 4  

改成 not s 是英文字母，或已到字串結尾

``` python
for i, s in 一行字串
    (i + 1) == len(一行字串)
```

最後的結果

``` python
import re

while True:
    word_start = False
    word_count = 0

    line_of_string = input()
    for i, c in enumerate(line_of_string):
        match = re.match(r'[a-zA-Z]', c)
        # match is None: 字元不是英文字母
        # i + 1 == len(line_of_string): 單純是該行結束了
        if word_start and (match is None or (i + 1) == len(line_of_string)):
            word_count += 1
            word_start = False
        if not word_start and not( match is None ):
            word_start = True

    print(word_count)

```