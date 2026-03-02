# Composable Modifiers

The `2.x` API is environment-driven and modifier-first.

## Data and range

```swift
LineChart()
    .chartData([Double])                 // categorical
    .chartData([(Double, Double)])       // numeric
    .chartXRange(0...10)                 // optional
    .chartYRange(0...100)                // optional
```

## Grid

```swift
ChartGrid {
    LineChart()
}
.chartGridLines(horizontal: 5, vertical: 6)
.chartGridStroke(style: StrokeStyle(lineWidth: 1, dash: [6]), color: .gray)
.chartGridBaseline(true, style: StrokeStyle(lineWidth: 1))
```

## Axis

```swift
AxisLabels {
    ChartGrid {
        LineChart()
    }
}
.chartXAxisLabels(["Q1", "Q2", "Q3", "Q4"])
.chartYAxisLabels(["0", "50", "100"])
.chartXAxisAutoTicks(6, format: .number)
.chartYAxisAutoTicks(5, format: .number)
.chartXAxisLabelRotation(.degrees(-20))
.chartAxisFont(.caption)
.chartAxisColor(.secondary)
```

## Line options

```swift
LineChart()
    .chartLineWidth(3)
    .chartLineBackground(ColorGradient(.blue.opacity(0.2), .clear))
    .chartLineMarks(true, color: ColorGradient(.blue, .purple))
    .chartLineStyle(.curved)     // or .straight
    .chartLineAnimation(true)
```

## Composition pattern

Recommended build order:

1. chart primitive (`LineChart`, `BarChart`, `PieChart`, `RingsChart`)
2. data + ranges (`chartData`, `chartXRange`, `chartYRange`)
3. style + chart-specific options
4. wrap in `ChartGrid`
5. wrap in `AxisLabels`
6. apply axis/grid interaction modifiers at container level
