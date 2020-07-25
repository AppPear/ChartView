import SwiftUI

public struct BarChart: View, ChartBase {
    public var chartData = ChartData()

    @EnvironmentObject var data: ChartData
    @EnvironmentObject var style: ChartStyle

    public var body: some View {
        BarChartRow(chartData: data, style: style)
    }

    public init() {}
}
