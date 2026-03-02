import SwiftUI

/// A type of chart that displays a slice of "pie" for each data point
public struct PieChart: View {
    @Environment(\.chartDataPoints) private var points
    @Environment(\.chartYRange) private var rangeY
    @Environment(\.chartXRange) private var rangeX
    @Environment(\.chartStyle) private var style
    @Environment(\.chartSeriesConfig) private var seriesConfig

    public init() {}

    public var body: some View {
        if isSeriesVisible {
            PieChartRow(chartData: ChartData(points, rangeY: rangeY, rangeX: rangeX), style: style)
                .aspectRatio(1, contentMode: .fit)
        }
    }

    private var isSeriesVisible: Bool {
        guard let seriesID = seriesConfig.seriesID else { return true }
        return !seriesConfig.hiddenSeriesIDs.contains(seriesID)
    }
}
