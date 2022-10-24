import SwiftUI

public struct LineChart: ChartBase {
    public var chartData = ChartData()
    @EnvironmentObject var style: ChartStyle
    public var chartProperties = LineChartProperties()

    public var body: some View {
       Line(chartData: chartData,
            style: style,
            chartProperties: chartProperties)
    }
    
    public init() {}
}
