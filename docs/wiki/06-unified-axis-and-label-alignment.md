# Unified Axis and Label Alignment

`2.x` uses a shared X-positioning pipeline across:

- chart rendering (`LineChart`, `BarChart`)
- axis labels (`AxisLabels`)

This removes drift where labels and marks used different spacing logic.

## Domain behavior

### Categorical data

```swift
chartData([Double])
```

- interpreted as category slots
- points are centered in slots
- labels map to slot-centered anchors

### Numeric data

```swift
chartData([(Double, Double)])
```

- interpreted as continuous numeric domain
- points map by numeric x-values and optional `chartXRange`

## Label APIs

```swift
.chartXAxisLabels(["M", "T", "W", "T", "F", "S", "S"])
.chartXAxisLabels([(0, "A"), (1, "B"), (2, "C")], range: 0...2)
```

## Auto ticks

```swift
.chartXAxisAutoTicks(6, format: .number)
.chartYAxisAutoTicks(5, format: .number)
.chartXAxisLabelRotation(.degrees(-20))
```

## Mixed bar + line guidance

For aligned mixed charts:

1. use the same data domain semantics for both layers
2. keep explicit `chartXRange` consistent when using numeric tuples
3. apply axis labels in the same container (`AxisLabels`) that wraps both layers
