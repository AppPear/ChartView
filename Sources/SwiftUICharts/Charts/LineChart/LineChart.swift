import SwiftUI

public struct LineChart: View {
    @Environment(\.chartDataPoints) private var points
    @Environment(\.chartYRange) private var rangeY
    @Environment(\.chartXRange) private var rangeX
    @Environment(\.chartXDomainMode) private var xDomainMode
    @Environment(\.chartStyle) private var style
    @Environment(\.chartLineConfig) private var lineConfig

    public init() {}

    public var body: some View {
        Line(chartData: ChartData(points, rangeY: rangeY, rangeX: rangeX, xDomainMode: xDomainMode),
             style: style,
             chartProperties: lineConfig)
    }
}
