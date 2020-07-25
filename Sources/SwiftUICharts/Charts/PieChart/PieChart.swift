import SwiftUI

public struct PieChart: View, ChartBase {
    public var chartData = ChartData()

    @EnvironmentObject var data: ChartData
    @EnvironmentObject var style: ChartStyle

    public var body: some View {
        PieChartRow(chartData: data, style: style)
    }

    public init() {}
}
