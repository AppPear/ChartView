# Getting Started

## Install

Add the package in Xcode using Swift Package Manager:

`https://github.com/AppPear/ChartView`

For version `2.0.0`, pin to tag `2.0.0` or use a `from: "2.0.0"` rule.

## Minimal line chart

```swift
import SwiftUI
import SwiftUICharts

struct ContentView: View {
    var body: some View {
        LineChart()
            .chartData([3, 5, 4, 8, 6, 9, 7])
            .chartStyle(
                ChartStyle(
                    backgroundColor: .white,
                    foregroundColor: ColorGradient(.blue, .purple)
                )
            )
            .frame(height: 180)
            .padding()
    }
}
```

## Compose grid + axis

```swift
AxisLabels {
    ChartGrid {
        LineChart()
            .chartData([12, 22, 18, 26, 24, 30, 28])
            .chartYRange(10...32)
            .chartStyle(
                ChartStyle(
                    backgroundColor: .white,
                    foregroundColor: ColorGradient(.green, .blue)
                )
            )
    }
    .chartGridLines(horizontal: 5, vertical: 6)
}
.chartXAxisLabels(["M", "T", "W", "T", "F", "S", "S"])
.chartAxisColor(.secondary)
.chartAxisFont(.caption)
```

## Core rule

In `2.x`, always use `chart...` modifiers. Legacy `1.x` mutating chains are removed.
