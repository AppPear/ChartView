import SwiftUI

public struct LineChart: View {
    @Environment(\.chartDataPoints) private var points
    @Environment(\.chartYRange) private var rangeY
    @Environment(\.chartXRange) private var rangeX
    @Environment(\.chartXDomainMode) private var xDomainMode
    @Environment(\.chartStyle) private var style
    @Environment(\.chartLineConfig) private var lineConfig
    @Environment(\.chartSeriesConfig) private var seriesConfig

    public init() {}

    public var body: some View {
        if isSeriesVisible {
            Line(chartData: ChartData(points, rangeY: rangeY, rangeX: rangeX, xDomainMode: xDomainMode),
                 style: style,
                 chartProperties: lineConfig)
        }
    }

    private var isSeriesVisible: Bool {
        guard let seriesID = seriesConfig.seriesID else { return true }
        return !seriesConfig.hiddenSeriesIDs.contains(seriesID)
    }
}
