import SwiftUI

public struct BarChart: ChartBase {
    public var chartData = ChartData()

    @EnvironmentObject var style: ChartStyle

    public var body: some View {
        BarChartRow(chartData: chartData, style: style)
    }

    public init() {}
}
