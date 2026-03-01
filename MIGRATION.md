# SwiftUICharts Migration Guide

## Version direction

This release moves to a strict SwiftUI-idiomatic modifier API.

- Immutable configuration
- `ViewModifier` composition
- Environment keys instead of mutable reference state in view structs

## Old -> new mapping

### Previous chart data/range chains

| Old | New |
| --- | --- |
| `.data([Double])` | `.chartData([Double])` |
| `.data([(Double, Double)])` | `.chartData([(Double, Double)])` |
| `.rangeX(...)` | `.chartXRange(...)` |
| `.rangeY(...)` | `.chartYRange(...)` |

### Grid chains

| Old | New |
| --- | --- |
| `.setNumberOfHorizontalLines(h)` + `.setNumberOfVerticalLines(v)` | `.chartGridLines(horizontal: h, vertical: v)` |
| `.setStoreStyle(style)` + `.setColor(color)` | `.chartGridStroke(style: style, color: color)` |
| `.showBaseLine(show, with: style)` | `.chartGridBaseline(show, style: style)` |

### Axis chains

| Old | New |
| --- | --- |
| `.setAxisXLabels([String])` | `.chartXAxisLabels([String])` |
| `.setAxisXLabels([(Double, String)], range:)` | `.chartXAxisLabels([(Double, String)], range:)` |
| `.setAxisYLabels([String], position:)` | `.chartYAxisLabels([String], position:)` |
| `.setAxisYLabels([(Double, String)], range:, position:)` | `.chartYAxisLabels([(Double, String)], range:, position:)` |
| `.setFont(font)` | `.chartAxisFont(font)` |
| `.setColor(color)` | `.chartAxisColor(color)` |

### Line-specific chains

| Old | New |
| --- | --- |
| `.setLineWidth(width:)` | `.chartLineWidth(...)` |
| `.setBackground(colorGradient:)` | `.chartLineBackground(...)` |
| `.showChartMarks(_, with:)` | `.chartLineMarks(_, color:)` |
| `.setLineStyle(to:)` | `.chartLineStyle(...)` |
| `.withAnimation(_)` | `.chartLineAnimation(...)` |

### Interaction wiring

| Old | New |
| --- | --- |
| `.chartValue(...)` on chart views | `.chartInteractionValue(...)` on any parent container |
| `@EnvironmentObject ChartValue` requirement | optional environment interaction value |

### Legacy public type replacements

| Legacy type | Replacement |
| --- | --- |
| `LineChartView` | `LineChart` with modifiers |
| `BarChartView` | `BarChart` with modifiers |
| `PieChartView` | `PieChart` with modifiers |
| `MultiLineChartView` | multiple `LineChart` overlays |
| `LineView` | `CardView` + `LineChart` + modifiers |
| `GradientColor` | `ColorGradient` |
| `GradientColors` | explicit `ColorGradient` values |
| `Colors` | `ChartColors` + `Color` |
| `Styles` | explicit `ChartStyle` initialization |
| `ChartForm` | SwiftUI layout (`frame`, stacks, spacing) |
| `MultiLineChartData` | multiple `chartData`-configured line layers |
| `MagnifierRect` | no direct replacement |
| `TestData` | app/test-local fixtures |

## Example migration

Before:

```swift
AxisLabels {
    ChartGrid {
        LineChart()
            .showChartMarks(true)
            .data([8, 23, 54, 32])
            .rangeY(0...60)
            .chartStyle(ChartStyle(backgroundColor: .white,
                                   foregroundColor: ColorGradient(.orange, .red)))
    }
    .setNumberOfHorizontalLines(5)
    .setNumberOfVerticalLines(4)
}
.setAxisXLabels(["Q1", "Q2", "Q3", "Q4"])
```

After:

```swift
AxisLabels {
    ChartGrid {
        LineChart()
            .chartLineMarks(true)
            .chartData([8, 23, 54, 32])
            .chartYRange(0...60)
            .chartStyle(ChartStyle(backgroundColor: .white,
                                   foregroundColor: ColorGradient(.orange, .red)))
    }
    .chartGridLines(horizontal: 5, vertical: 4)
}
.chartXAxisLabels(["Q1", "Q2", "Q3", "Q4"])
```
