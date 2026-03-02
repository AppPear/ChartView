import SwiftUI

public struct LineChart: View {
    @Environment(\.chartDataPoints) private var points
    @Environment(\.chartYRange) private var rangeY
    @Environment(\.chartXRange) private var rangeX
    @Environment(\.chartXDomainMode) private var xDomainMode
    @Environment(\.chartStyle) private var style
    @Environment(\.chartLineConfig) private var lineConfig
    @Environment(\.chartSeriesConfig) private var seriesConfig
    @Environment(\.chartPerformanceConfig) private var performanceConfig

    public init() {}

    public var body: some View {
        if isSeriesVisible {
            Line(chartData: ChartData(performanceAdjustedPoints,
                                      rangeY: rangeY,
                                      rangeX: rangeX,
                                      xDomainMode: xDomainMode),
                 style: style,
                 chartProperties: performanceAdjustedLineConfig)
        }
    }

    private var isSeriesVisible: Bool {
        guard let seriesID = seriesConfig.seriesID else { return true }
        return !seriesConfig.hiddenSeriesIDs.contains(seriesID)
    }

    private var performanceAdjustedPoints: [(Double, Double)] {
        let downsampled: [(Double, Double)]

        switch performanceConfig.mode {
        case .none:
            downsampled = points
        case .automatic(let threshold, let maxPoints, _):
            if points.count > max(2, threshold) {
                downsampled = ChartDownsampler.reduced(points, maxPoints: maxPoints)
            } else {
                downsampled = points
            }
        case .downsample(let maxPoints, _):
            downsampled = ChartDownsampler.reduced(points, maxPoints: maxPoints)
        }

        if xDomainMode == .categorical {
            return downsampled.enumerated().map { index, value in
                (Double(index), value.1)
            }
        }

        return downsampled
    }

    private var performanceAdjustedLineConfig: ChartLineConfig {
        var updated = lineConfig

        let shouldSimplify: Bool
        switch performanceConfig.mode {
        case .none:
            shouldSimplify = false
        case .automatic(let threshold, _, let simplify):
            shouldSimplify = simplify && points.count > max(2, threshold)
        case .downsample(_, let simplify):
            shouldSimplify = simplify
        }

        if shouldSimplify {
            updated.lineStyle = .straight
            updated.showChartMarks = false
            updated.animationEnabled = false
        }

        return updated
    }
}
