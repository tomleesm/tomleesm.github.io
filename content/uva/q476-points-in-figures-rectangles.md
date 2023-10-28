---
title: "Q476 Points in Figures: Rectangles"
date: 2023-10-29T05:14:51+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
```
r 8.5 17.0 25.5 -8.5
類別 左上x 左上y 右下x 右下y (x1 y2 x2 y1)
所以 x 在 8.5 ~ 25.5, y 在 -8.5 ~ 17.0

*
2.0 2.0
x   y
```

點的 x 要在矩形的 x 範圍內且 y 在矩形的 y 的範圍內，則點在此矩形內。剛好落在邊上的點不視為落在該矩形內，所以 `矩形的 x1 < 點的 x < 矩形的 x2`，`矩形的 y1 < 點的 y < 矩形的 y2`，不含`x` 等於 `x1` 或 `x2` 的邊界情況

x = 2.0 不在 8.5 ~ 25.5 內，所以第一個點不在第一個矩形內

1. 輸入矩形座標
2. 輸入點座標
3. 檢查點是否在矩形內
   1. 抓出一個點
   2. 抓出一個矩形
   3. if 點的x在矩形的x1 ~ x2 且 y 在矩形的y1 ~ y2，則輸出 Point i is contained in figure j
   4. 如果所有矩形檢查過都沒有，則輸出 Point i is not contained in any figure

輸入矩形座標

讀取 terminal 輸入 --> `input()` 一次讀取一行

```
if 只有一個一個字元且為 `*`
    矩形輸入結束
```

所以
``` python
while True:
    s = input()
    if len(s) == 1 and s == "*":
        break
    else:
```
抓取矩形座標，放到 dict ，再放到 list

``` python
rectangles = []
r = s.split() # --> ['r', '8.5', '17.0', '25.5', '-8.5']
rectangle = {
        "x1": float(r[1]),
        "y2": float(r[2]),
        "x2": float(r[3]),
        "y1": float(r[4]),
    }
    rectangles.append(rectangle)
```

輸入點座標，和輸入矩形座標差不多

``` python
while True:
    s = input()
    p = s.split() # --> ['2.0', '2.0']
    if len(p) == 2 and p[0] == "9999.9" and p[1] == "9999.9":
        break
    else:
        points = []
        point = { "x": float(p[0]), "y": float(p[1]) }
        points.append(point)
```

檢查點是否在矩形內

``` python
i = 0, j = 0
for point in points:
    i = i + 1
    is_point_in_rectangles = False
    for rectangle in recangles:
        j = j + 1
        if rectangle['x1'] < point['x'] < rectangle['x2']:
            print('Point ' + i + ' is contained in figure ' + j)
            is_point_in_rectangle = True

    if not is_point_in_rectangle:
        print('Point ' + i + ' is not contained in any figure')
```

最後結果：有修改小地方

``` python
# 新增矩形
rectangles = []
while True:
    s = input()
    if len(s) == 1 and s == "*":
        break

    r = s.split()
    rectangle = {
        "x1": float(r[1]),
        "y2": float(r[2]),
        "x2": float(r[3]),
        "y1": float(r[4]),
    }
    rectangles.append(rectangle)

# 新增點
points = []
while True:
    s = input()
    p = s.split()
    if len(p) == 2 and p[0] == "9999.9" and p[1] == "9999.9":
        break

    point = { "x": float(p[0]), "y": float(p[1]) }
    points.append(point)

# 判斷點是否在矩形內
for i, p in enumerate(points):
    contained_in_figure = False
    for j, r in enumerate(rectangles):
        if r["x1"] < p["x"] < r["x2"] and r["y1"] < p["y"] < r["y2"]:
            print("Point {} is contained in figure {}".format(i + 1, j + 1))
            contained_in_figure = True

    if not contained_in_figure:
        print("Point {0} is not contained in any figure".format(i + 1))
```