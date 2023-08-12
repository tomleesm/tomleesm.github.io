---
title: "Q458 The Decoder"
date: 2023-08-07T15:53:30+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
a -- +2 --> c -- -2 --> a  
p ---> r ---> p  
p ---> r ---> p  
l ---> n ---> l  

K 是多少？

1 --- -K --> `*`  
J ---> C  
K ---> D  
J ---> C  

AB*C*DEFGHI*J*K

所以 K = 7

```
while True
    輸入一列字串
    抓取每一個字元
    字元減掉 K(=7)
    把解密後的字元存到字串
    print 字串
```

``` python
while True:
    password = input()
    result = ""
    for c in password:
```

STUCK：字元是字串，不能直接減掉 7  
AHA 字元 ---> ASCII Code ---> 減掉 7 ---> 字元  
A ---- `ord('A')` --> 65 ---> 58 ---- `chr(58)` --> `:`

``` python
ascii_code = ord(c) - 7
decoded_c = chr(ascii_code)
result += decoded_c

print(result)
```

最後結果

``` python
K = 7
while True:
    # 輸入一列字串
    password = input()
    # 抓取每個字元
    decoded_password = ''
    for c in password:
        # 字元減掉 K(= 7)
        #   字元 --> ASCII Code --> 減掉 K --> 字元
        ascii_code = ord(c)
        decoded_ascii_code = ascii_code - K
        decoded_char = chr(decoded_ascii_code)
        # 把解密後的字元存到字串
        decoded_password += decoded_char
    # print 字串
    print(decoded_password)
```

測試資料

```
# 輸入
1JKJ'pz'{ol'{yhklthyr'vm'{ol'Jvu{yvs'Kh{h'Jvywvyh{pvu5
# 輸出
*CDC is the trademark of the Control Data Corporation.
```