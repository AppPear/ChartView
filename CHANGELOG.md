# Changelog

## 2.0.0-beta.9

### Added

- Full SwiftUI-idiomatic modifier API:
  - `chartData`, `chartXRange`, `chartYRange`
  - `chartGridLines`, `chartGridStroke`, `chartGridBaseline`
  - `chartXAxisLabels`, `chartYAxisLabels`, `chartAxisFont`, `chartAxisColor`
  - `chartLineWidth`, `chartLineBackground`, `chartLineMarks`, `chartLineStyle`, `chartLineAnimation`
  - `chartInteractionValue`
- Immutable chart configuration structs and environment-key-based composition.
- Updated docs/examples and generated showcase app.

### Changed

- Major clean break from mutating chain APIs.
- Chart style/data/range/axis/grid/line configs are now modifier-driven and value-based.

### Fixed

- Removed required `@EnvironmentObject` interaction dependency for basic chart rendering paths.
- Existing regression and smoke tests remain green after API shift.

### Migration

- See `MIGRATION.md` for full old-to-new mapping.
