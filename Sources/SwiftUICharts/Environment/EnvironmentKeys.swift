import SwiftUI

struct ChartTypeKey: EnvironmentKey {
    static let defaultValue: AnyChartType = AnyChartType(BarChart())
}

struct ChartStyleKey: EnvironmentKey {
    static let defaultValue: ChartStyle = ChartStyle(backgroundColor: .white,
                                                     foregroundColor: ColorGradient(ChartColors.orangeDark,
                                                                                    ChartColors.orangeBright))
}

struct ChartValueKey: EnvironmentKey {
    static let defaultValue: ChartValue = ChartValue()
}
