# SwiftUICharts

Swift package for displaying charts effortlessly.

![SwiftUI Charts](./chartview.gif "SwiftUI Charts")

It supports currently:
* barcharts
* piecharts

### Installation:

It requires iOS 13 and xCode 11!

In xCode got to `File -> Swift Packages -> Add Package Dependency` and paste inthe repo's url: `https://github.com/AppPear/ChartView`

### Usage:

import the package in the file you would like to use it: `import SwiftUICharts`

You can display a Chart by adding a chart view to your parent view: 

Barchart:
```swift
ChartView(data: [8,23,54,32,12,37,7,23,43], title: "Barchart")
```

Piechart:
```swift
PieChartView(data:[43,56,78,34], title: "Piechart")
```

You can optionally configure:
* legend
* background color
* accent color
* size format

### Size format (only for bar charts yet!)

![Chart forms](./chartforms.png "Chart forms")

Can be 
* small
* medium
* large

```swift
ChartView(data: [12,17,24,33,23,56], title: "Chart two", form: Form.small)
```

### Customizing color: 
I added color constants, so you can predefine your color palette. To do so, you can find `Colors` struct in the ChartColors swift file.

```swift
ChartView(data: [12,17,24,33,23,56], title: "Chart two", backgroundColor:Colors.color3 , accentColor:Colors.color3Accent)
```


