---
title: "Q488 Triangle Wave"
date: 2023-10-30T14:52:28+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
2 --> 有 2 組測試資料

3 --> A 振幅 (A <= 9)
2 --> F 頻率

5
3

STUCK: 什麼是振幅？
AHA: 波上下起伏的大小

STUCK: 什麼是頻率？
AHA: 例如每秒幾次(幾個波)。相反的，週期是指做一次(一個波)要多久

F = 2 --> 輸出 2 個波，每個波振幅的水平高度為 A --> A = 3 --> 波最大為 333

STUCK: 要怎麼輸入資料？
``` python
n = int(input())
groups = []
for i in range(0, n):
    A = int(input())
    F = int(input())
    group = { 'A': A, 'F': F}
    groups.append(group) # for 抓出一個 group['A'] 為 A 的值(振幅)
```

STUCK: 如果 A = 3, 要怎麼產生波如下？

```
1
22
333
22
1
```

1) 先產生 333

``` python
for i in range(0, 3):
    print(3, end="") # 不換行
```

2) 產生

```
1
22
333
```

``` python
for A in range(1, 4):
    for i in range(0, A):
        print(A, end="")
    print()
```

3) 產生

```
22
1
```

愈來愈少(2, 1)

``` python
for A in range(2, 0, -1):
    for i in range(0, A):
        print(A, end="")
    print()
```

產生一個波：2) + 3)

``` python
A = 3
# 2)
for i in range(1, A + 1):
    for j in range(0, i):
        print(i, end="")
    print()
# 3)
for i in range(A - 1, 0, -1):
    for j in range(0, i):
        print(i, end="")
    print()
```

產生多個波就包上一個 for 迴圈，外面再包上一個 for 表示有多筆測試資料

``` python
for group in groups:
    # 共產生 F 個波
    for f in range(0, F):
        # 帶入上面的產生一個波
    print()
```

最後組裝起來，調整一下

``` python
# 輸入有 n 組測試資料
n = int(input())
print()

# 開始輸入測試資料
groups = []
for i in range(0, n):
    A = int(input())
    F = int(input())
    group = {"A": A, "F": F}
    groups.append(group)
    print()

for group in groups:
    A = group['A']
    F = group['F']
    # 產生幾個波
    for f in range(0, F):

        # 產生一個波
        # 如果 A = 3
        # 1
        # 22
        # 333
        for i in range(1, A + 1):
            for j in range(0, i):
                print( i , end="" )
            print()
        # 22
        # 1
        for i in range(A - 1, 0, -1):
            for j in range(0, i):
                print(i, end="")
            print()
        # 產生一個波後，換行
        print()
```