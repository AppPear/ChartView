import SwiftUI

public struct LineChart: View, ChartBase {
    public var chartData = ChartData()

    @EnvironmentObject var data: ChartData
    @EnvironmentObject var style: ChartStyle

    public var body: some View {
        Line(chartData: data, style: style)
    }
    
    public init() {}
}
