# Changelog

## 2.0.0

### Added

- Full SwiftUI-idiomatic modifier API:
  - `chartData`, `chartXRange`, `chartYRange`
  - `chartGridLines`, `chartGridStroke`, `chartGridBaseline`
  - `chartXAxisLabels`, `chartYAxisLabels`, `chartAxisFont`, `chartAxisColor`
  - `chartLineWidth`, `chartLineBackground`, `chartLineMarks`, `chartLineStyle`, `chartLineAnimation`
  - `chartInteractionValue`
  - `chartSelectionHandler`
  - `chartPerformance`
- Immutable chart configuration structs and environment-key-based composition.
- Updated docs/examples and generated showcase app.
- Dynamic streaming data source support via `ChartStreamingDataSource`.
- Unified X-axis alignment strategy shared across chart layers.
- Apple privacy manifest for SDK distribution (`PrivacyInfo.xcprivacy`).

### Changed

- Major clean break from mutating chain APIs.
- Chart style/data/range/axis/grid/line configs are now modifier-driven and value-based.

### Fixed

- Removed required `@EnvironmentObject` interaction dependency for basic chart rendering paths.
- Existing regression and smoke tests remain green after API shift.

### Migration

- See `MIGRATION.md` for full old-to-new mapping.
