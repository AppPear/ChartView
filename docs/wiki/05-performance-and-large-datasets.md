# Performance and Large Datasets

`LineChart` supports built-in downsampling through `chartPerformance(_:)`.

## Modes

```swift
public enum ChartPerformanceMode {
    case none
    case automatic(threshold: Int, maxPoints: Int, simplifyLineStyle: Bool)
    case downsample(maxPoints: Int, simplifyLineStyle: Bool)
}
```

## Recommended setup

```swift
LineChart()
    .chartData(largeSeries) // e.g. 2000+ points
    .chartPerformance(.automatic(
        threshold: 600,
        maxPoints: 180,
        simplifyLineStyle: true
    ))
```

## What simplification changes

When `simplifyLineStyle` is enabled:

- line style switches to straight
- chart marks are disabled
- line animation is disabled

This reduces render overhead for dense data.

## For categorical data

For `chartData([Double])`, downsampled values are remapped to categorical slot indices to keep axis alignment stable.

## Validation checklist

1. Compare visual shape with and without downsampling.
2. Ensure tooltips/selection still target expected points.
3. Tune `threshold` and `maxPoints` for your dataset size and UI refresh rate.
