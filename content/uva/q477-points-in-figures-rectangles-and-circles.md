---
title: "Q477 Points in Figures: Rectangles and Circles"
date: 2023-10-30T12:42:02+08:00
toc: false
authors:
  - Tom
lightgallery: false
draft: false
---
輸入有兩種形狀：矩形和圓形

r 8.5 17.0 25.5 -8.5 --> 矩形
c 20.2 7.3 5.8 --> 圓形
  20.2 7.3 是圓心座標， 5.8 是圓半徑

STUCK：怎麼知道點是否在圓內？
AHA：(畫圖：一個圓和幾個點) 點到圓心的距離小於圓半徑

STUCK：點到圓心的距離怎麼計算？
AHA：如果點 p = (3, 4), 圓心 c = (10, 20)，距離 = 開根號( (3 - 10)的平方 + (4 - 20)的平方 )
附註：上面這一行在紙上實際上是數學公式，只是不方便輸入到電腦上，所以這樣寫

輸入形狀

```
if 形狀是矩形
    抓 4 個座標值
else if 形狀是圓形
    抓圓心座標和半徑
```

輸入點：同 Q476

檢查是否在圓形內

```
抓一個點
    抓一個圖形
        if 圖形是矩形
            矩形 x1 < 點 x < 矩形 x2, 矩形 y1 < 點 y < 矩形 y2
        else if 圖形是圓形
            開根號( (點x - 圓心x)的平方 + (點y - 圓心y)的平方 ) < 圓半徑
```

開根號 `math.sqrt()`，平方 `math.pow(點x - 圓心x, 2)`

``` python
import math

# 新增矩形
shapes = []
while True:
    s = input()
    if s == "*":
        break

    r = s.split()
    # 輸入矩形
    if r[0] == "r":
        shape = {
            "type": "rectangle",
            "x1": float(r[1]),
            "y2": float(r[2]),
            "x2": float(r[3]),
            "y1": float(r[4]),
        }
    # 輸入圓形
    elif r[0] == "c":
        shape = {
            "type": "circle",
            "x": float(r[1]),
            "y": float(r[2]),
            "r": float(r[3])
        }
    shapes.append(shape)

# 新增點
points = []
while True:
    s = input()
    p = s.split()
    if p[0] == "9999.9" and p[1] == "9999.9":
        break

    point = {"x": float(p[0]), "y": float(p[1])}
    points.append(point)

# 判斷點是否在矩形內
contained_in_figure = False
for i, point in enumerate(points):
    for j, shape in enumerate(shapes):
        if (
            shape["type"] == "rectangle"
            and shape["x1"] < point["x"] < shape["x2"]
            and shape["y1"] < point["y"] < shape["y2"]
        ):
            print("Point {} is contained in figure {}".format(i + 1, j + 1))
            contained_in_figure = True
        elif (
            shape["type"] == "circle"
            and math.sqrt(math.pow(shape["x"] - point["x"], 2) + math.pow(shape["y"] - point["y"], 2))
            < shape["r"]
        ):
            print("Point {} is contained in figure {}".format(i + 1, j + 1))
            contained_in_figure = True

    if not contained_in_figure:
        print("Point {0} is not contained in any figure".format(i + 1))

    contained_in_figure = False
```
