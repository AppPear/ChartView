import SwiftUI

struct ChartTypeKey: EnvironmentKey {
    static let defaultValue: AnyChartType = AnyChartType(BarChart())
}

struct ChartStyleKey: EnvironmentKey {
    static let defaultValue: ChartStyle = ChartStyle(backgroundColor: .white,
                                                     foregroundColor: ColorGradient(ChartColors.orangeBright,
                                                                                    ChartColors.orangeDark))
}

struct ChartLabelKey: EnvironmentKey {
    static let defaultValue: AnyChartLabel = AnyChartLabel(TitleLabel())
}
