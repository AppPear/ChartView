import SwiftUI

public struct BarChart: View {
    @Environment(\.chartDataPoints) private var points
    @Environment(\.chartYRange) private var rangeY
    @Environment(\.chartXRange) private var rangeX
    @Environment(\.chartStyle) private var style

    public init() {}

    public var body: some View {
        BarChartRow(chartData: ChartData(points, rangeY: rangeY, rangeX: rangeX), style: style)
    }
}
