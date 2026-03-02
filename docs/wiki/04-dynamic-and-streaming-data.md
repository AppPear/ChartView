# Dynamic and Streaming Data

Use `ChartStreamingDataSource` for live or mock dynamic feeds.

## Basic setup

```swift
@ObservedObject private var stream = ChartStreamingDataSource(
    initialValues: [18, 21, 20, 24, 23, 26],
    windowSize: 6,
    autoScroll: true
)
```

## Bind to a chart

```swift
AxisLabels {
    ChartGrid {
        LineChart()
            .chartData(stream)
            .chartYRange(stream.suggestedYRange)
            .chartStyle(
                ChartStyle(
                    backgroundColor: .white,
                    foregroundColor: ColorGradient(.green, .blue)
                )
            )
    }
    .chartGridLines(horizontal: 5, vertical: max(2, stream.values.count))
}
.chartXAxisLabels(stream.xLabels)
```

## Update the stream

```swift
stream.append(27)
stream.append(contentsOf: [26, 29, 31])
stream.reset([15, 17, 16], startingIndex: 1)
```

## Source behavior

- `windowSize`: max visible points (with `autoScroll == true`)
- `autoScroll`: trims oldest points after overflow
- `xLabels`: generated from current visible window indices
- `suggestedYRange`: dynamic padded range based on current values

## Internet-backed flow

Typical pattern:

1. fetch values from API
2. map response to `[Double]`
3. call `stream.append(...)` or `stream.reset(...)`
4. chart updates automatically through `ObservableObject`
