# Interaction and Selection

`2.x` supports two interaction styles:

1. shared observable value (`ChartValue`)
2. callback events (`chartSelectionHandler`)

## Shared interaction value

Use when multiple views should react to the same selection state.

```swift
let selected = ChartValue()

VStack(alignment: .leading) {
    ChartLabel("Weekly Sales", type: .title)
    ChartLabel("Drag to inspect values", type: .legend, format: "%.1f")

    BarChart()
        .chartData([12, 18, 16, 24, 21, 19, 22])
}
.chartInteractionValue(selected)
```

## Callback-based interaction

Use when you prefer event handling and do not want shared object state.

```swift
@State private var selectionText = "No selection"

BarChart()
    .chartData([8, 12, 10, 14, 9])
    .chartSelectionHandler { event in
        guard event.isActive,
              let value = event.value,
              let index = event.index else {
            selectionText = "No selection"
            return
        }
        selectionText = "Selected index \(index): \(value)"
    }
```

## `ChartSelectionEvent`

```swift
public struct ChartSelectionEvent {
    public let value: Double?
    public let index: Int?
    public let isActive: Bool
}
```

## Notes

- Basic rendering does not require `ChartValue`.
- Interaction is available on line, bar, pie, and rings charts.
- `ChartLabel` displays static text unless `chartInteractionValue` is present.
