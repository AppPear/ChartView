import SwiftUI

public struct RingsChart: View {
    @Environment(\.chartDataPoints) private var points
    @Environment(\.chartYRange) private var rangeY
    @Environment(\.chartXRange) private var rangeX
    @Environment(\.chartStyle) private var style

    public init() {}

    public var body: some View {
        RingsChartRow(width: 10.0,
                      spacing: 5.0,
                      chartData: ChartData(points, rangeY: rangeY, rangeX: rangeX),
                      style: style)
            .aspectRatio(1, contentMode: .fit)
    }
}
