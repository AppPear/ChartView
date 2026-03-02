# Migration from 1.x

This page summarizes migration to `2.0.0`.

## Breaking change summary

- Legacy chart view types are replaced by composable chart primitives.
- Legacy mutating method chains are replaced by modifier APIs.
- Interaction no longer requires `@EnvironmentObject`.

## Replace these first

| 1.x | 2.x |
| --- | --- |
| `LineChartView` | `LineChart` |
| `BarChartView` | `BarChart` |
| `PieChartView` | `PieChart` |
| `MultiLineChartView` | multiple `LineChart` layers |

## Replace common method chains

| 1.x | 2.x |
| --- | --- |
| `.data(...)` | `.chartData(...)` |
| `.rangeX(...)` | `.chartXRange(...)` |
| `.rangeY(...)` | `.chartYRange(...)` |
| `.setAxisXLabels(...)` | `.chartXAxisLabels(...)` |
| `.setNumberOfHorizontalLines(...)` | `.chartGridLines(...)` |
| `.showChartMarks(...)` | `.chartLineMarks(...)` |

## Interaction migration

Pick one:

1. shared state:
   - `.chartInteractionValue(ChartValue())`
2. callback style:
   - `.chartSelectionHandler { event in ... }`

## Full mapping

See [MIGRATION.md](../../MIGRATION.md) for complete type + method mapping.
