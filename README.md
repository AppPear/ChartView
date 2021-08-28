# SwiftUICharts

Swift package for displaying charts effortlessly.

## V2 Beta is here 🎉🎉🎉

V2 focuses on providing a strong and easy to use base, on which you can build your beautiful custom charts. It provides basic building blocks, like a chart view (bar, pie, line and ring chart), grid view, card view, interactive label for displaying the curent chart value. 
So you decide, whether you build a fully fledged interactive view, or just display a bare bone chart

* [How to install SwiftUI ChartView](https://github.com/AppPear/ChartView/wiki/How-to-install-SwiftUI-ChartView)

* [How to create your first chart](https://github.com/AppPear/ChartView/wiki/How-to-create-your-first-chart)

### It supports interactions and animations
<img src="https://user-images.githubusercontent.com/2826764/130787802-9aa619ee-05de-4343-ba3c-1796e4d05e08.gif" width="26%"></img> <img src="https://user-images.githubusercontent.com/2826764/130787814-283f3d26-6c9d-448b-b2c7-879e60a3b05d.gif" width="26%"></img> 

### It is fully customizable, and works together with native SwiftUI elements well
<img src="https://user-images.githubusercontent.com/2826764/130785262-010d6791-16cf-485d-b920-29e4086477e2.png" width="45%"></img> <img src="https://user-images.githubusercontent.com/2826764/130785266-94a08622-2963-4177-8777-8bd3ad463809.png" width="45%"></img> <img src="https://user-images.githubusercontent.com/2826764/130785268-284314de-ba96-4fb7-a1e5-8a46578e1f0e.png" width="45%"></img> 


## Original (stable) version: 

<img src="https://user-images.githubusercontent.com/2826764/131211993-5d33312b-09af-44b4-a32e-ffaad739adfe.gif" width="45%"></img> <img src="https://user-images.githubusercontent.com/2826764/131211994-48c9ce4e-2e67-40a0-b727-c88bdbd22cd0.gif" width="45%">

### Usage

It supports:
* Line charts
* Bar charts
* Pie charts

### Slack
Join our Slack channel for day to day conversation and more insights:

[Slack invite link](https://join.slack.com/t/swiftuichartview/shared_invite/zt-g6mxioq8-j3iUTF1YKX7D23ML3qcc4g)

### Installation:

It requires iOS 13 and Xcode 11!

In Xcode go to `File -> Swift Packages -> Add Package Dependency` and paste in the repo's url: `https://github.com/AppPear/ChartView`

### Usage:

import the package in the file you would like to use it: `import SwiftUICharts`

You can display a Chart by adding a chart view to your parent view: 

### Demo

Added an example project, with **iOS, watchOS** target: https://github.com/AppPear/ChartViewDemo

## Line charts

**LineChartView with multiple lines!**
First release of this feature, interaction is disabled for now, I'll figure it out how could be the best to interact with multiple lines with a single touch.

<img src="https://user-images.githubusercontent.com/2826764/131211991-eca64276-cf05-423f-a78a-697c55e44bbc.gif" width="50%"></img>

Usage:
```swift
MultiLineChartView(data: [([8,32,11,23,40,28], GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Title")
```
Gradient colors are now under the `GradientColor` struct you can create your own gradient by `GradientColor(start: Color, end: Color)`

Available preset gradients: 
* orange 
* blue
* green
* blu 
* bluPurpl
* purple
* prplPink 
* prplNeon
* orngPink

**Full screen view called LineView!!!**


```swift
 LineView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Full screen") // legend is optional, use optional .padding()
```

Adopts to dark mode automatically 

<img src="https://user-images.githubusercontent.com/2826764/131211977-27439357-491d-4872-a6bd-f696edac4c7f.gif" width="45%"></img> <img src="https://user-images.githubusercontent.com/2826764/131211985-f77464d6-7fd8-429d-9e77-9f9bc7424d32.gif" width="45%">

You can add your custom darkmode style by specifying:

```swift
let myCustomStyle = ChartStyle(...)
let myCutsomDarkModeStyle = ChartStyle(...)
myCustomStyle.darkModeStyle = myCutsomDarkModeStyle
```

**Line chart is interactive, so you can drag across to reveal the data points**

You can add a line chart with the following code: 

```swift
 LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", legend: "Legendary") // legend is optional
```

**Turn drop shadow off by adding to the Initialiser: `dropShadow: false`**


## Bar charts
<img src="https://user-images.githubusercontent.com/2826764/131211994-48c9ce4e-2e67-40a0-b727-c88bdbd22cd0.gif" width="45%">

**[New feature] you can display labels also along values and points for each bar to descirbe your data better!**
**Bar chart is interactive, so you can drag across to reveal the data points**

You can add a bar chart with the following code: 

Labels and points:

```swift
 BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "Sales", legend: "Quarterly") // legend is optional
```
Only points:

```swift
 BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Title", legend: "Legendary") // legend is optional
```

**ChartData** structure
Stores values in data pairs (actually tuple): `(String,Double)`
* you can have duplicate values
* keeps the data order

You can initialise ChartData multiple ways:
* For integer values: `ChartData(points: [8,23,54,32,12,37,7,23,43])`
* For floating point values: `ChartData(points: [2.34,3.14,4.56])`
* For label,value pairs: `ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900)])`


You can add different formats: 
* Small `ChartForm.small`
* Medium  `ChartForm.medium`
* Large `ChartForm.large` 

```swift
BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Title", form: ChartForm.small)
```

For floating point numbers, you can set a custom specifier: 

```swift
BarChartView(data: ChartData(points:[1.23,2.43,3.37]) ,title: "A", valueSpecifier: "%.2f")
```
For integers you can disable by passing: `valueSpecifier: "%.0f"`


You can set your custom image in the upper right corner by passing in the initialiser: `cornerImage:Image(systemName: "waveform.path.ecg")` 


 **Turn drop shadow off by adding to the Initialiser: `dropShadow: false`**

 ### You can customize styling of the chart with a ChartStyle object: 

Customizable: 
* background color
* accent color
* second gradient color
* text color
* legend text color

```swift
 let chartStyle = ChartStyle(backgroundColor: Color.black, accentColor: Colors.OrangeStart, secondGradientColor: Colors.OrangeEnd, chartFormSize: ChartForm.medium, textColor: Color.white, legendTextColor: Color.white )
 ...
 BarChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", style: chartStyle)
```

You can access built-in styles: 
```swift
 BarChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", style: Styles.barChartMidnightGreen)
```
#### All styles available as a preset: 
* barChartStyleOrangeLight
* barChartStyleOrangeDark
* barChartStyleNeonBlueLight
* barChartStyleNeonBlueDark
* barChartMidnightGreenLight
* barChartMidnightGreenDark

<img src="https://user-images.githubusercontent.com/2826764/131211990-e41cec90-38f4-4965-8bdc-41c30b79acea.gif" width="45%">

<img src="https://user-images.githubusercontent.com/2826764/131211999-6ec4f13b-0465-4135-b576-76e31b11a2c6.png" width="45%">

### You can customize the size of the chart with a ChartForm object: 

**ChartForm**
* `.small`
* `.medium`
* `.large`
* `.detail`

```swift
BarChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", form: ChartForm.small)
```

### You can choose whether bar is animated or not after completing your gesture.

If you want to animate back movement after completing your gesture, you set `animatedToBack` as `true`. 

### WatchOS support for Bar charts: 

<img src="https://user-images.githubusercontent.com/2826764/131212000-a058fdd9-af40-4e64-adc3-82201ea2484d.png" width="45%">

## Pie charts
<img src="https://user-images.githubusercontent.com/2826764/131211998-e142657d-0ebc-43b7-aeda-07cae4d9e34b.png" width="45%">

You can add a pie chart with the following code: 

```swift
 PieChartView(data: [8,23,54,32], title: "Title", legend: "Legendary") // legend is optional
```

**Turn drop shadow off by adding to the Initialiser: `dropShadow: false`**

