import SwiftUI

public struct AxisLabels<Content: View>: View {
    @Environment(\.chartAxisConfig) private var axisConfig
    @State private var preferredDataPoints: [(Double, Double)] = []
    @State private var preferredXRange: ClosedRange<Double>?
    @State private var preferredXDomainMode: ChartXDomainMode = .numeric

    private let yAxisWidth: CGFloat = 42
    private let xAxisHeight: CGFloat = 24

    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    private var hasYLabels: Bool {
        !axisConfig.axisYLabels.isEmpty
    }

    private var hasXLabels: Bool {
        !axisConfig.axisXLabels.isEmpty
    }

    private var effectiveYAxisWidth: CGFloat {
        hasYLabels ? yAxisWidth : 0
    }

    private var effectiveXAxisHeight: CGFloat {
        hasXLabels ? xAxisHeight : 0
    }

    private var leftAxisGutter: CGFloat {
        axisConfig.axisLabelsYPosition == .leading ? effectiveYAxisWidth : 0
    }

    private var rightAxisGutter: CGFloat {
        axisConfig.axisLabelsYPosition == .trailing ? effectiveYAxisWidth : 0
    }

    private var visibleXValues: [Double] {
        preferredDataPoints
            .filter { preferredXRange?.contains($0.0) ?? true }
            .map(\.0)
    }

    private var xRangeForScale: ClosedRange<Double>? {
        preferredXRange ?? axisConfig.axisXRange
    }

    private var xDomainModeForScale: ChartXDomainMode {
        preferredDataPoints.isEmpty ? axisConfig.axisXDomainMode : preferredXDomainMode
    }

    private var xScale: ChartXScale {
        let scaleValues = visibleXValues.isEmpty ? axisConfig.axisXLabels.map(\.value) : visibleXValues
        return ChartXScale(values: scaleValues,
                           rangeX: xRangeForScale,
                           mode: xDomainModeForScale,
                           slotCountHint: max(scaleValues.count, axisConfig.axisXLabels.count))
    }

    var yAxis: some View {
        VStack(spacing: 0) {
            ForEach(Array(axisConfig.axisYLabels.reversed().enumerated()), id: \.offset) { index, axisYData in
                Text(axisYData)
                    .font(axisConfig.axisFont)
                    .foregroundColor(axisConfig.axisFontColor)
                    .frame(maxWidth: .infinity,
                           alignment: axisConfig.axisLabelsYPosition == .leading ? .trailing : .leading)

                if index < axisConfig.axisYLabels.count - 1 {
                    Spacer(minLength: 0)
                }
            }
        }
        .padding(.horizontal, 4)
    }

    var xAxis: some View {
        GeometryReader { geometry in
            let safeSize = geometry.size.sanitized
            let width = safeSize.width

            ZStack(alignment: .topLeading) {
                ForEach(Array(axisConfig.axisXLabels.enumerated()), id: \.offset) { _, xLabel in
                    positionedXLabel(xLabel, width: width)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: xAxisHeight, alignment: .top)
    }

    public var body: some View {
        GeometryReader { geometry in
            let safeSize = geometry.size.sanitized
            let axisHeight = effectiveXAxisHeight
            let chartHeight = max(0, safeSize.height - axisHeight)

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    if leftAxisGutter > 0 {
                        yAxis
                            .frame(width: leftAxisGutter, height: chartHeight, alignment: .trailing)
                    }

                    content()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                    if rightAxisGutter > 0 {
                        yAxis
                            .frame(width: rightAxisGutter, height: chartHeight, alignment: .leading)
                    }
                }
                .frame(height: chartHeight, alignment: .top)

                if axisHeight > 0 {
                    HStack(spacing: 0) {
                        if leftAxisGutter > 0 {
                            Color.clear.frame(width: leftAxisGutter, height: axisHeight)
                        }

                        xAxis
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                        if rightAxisGutter > 0 {
                            Color.clear.frame(width: rightAxisGutter, height: axisHeight)
                        }
                    }
                    .frame(height: axisHeight, alignment: .top)
                }
            }
            .frame(width: safeSize.width, height: safeSize.height, alignment: .topLeading)
        }
        .onPreferenceChange(ChartDataPointsPreferenceKey.self) { snapshot in
            preferredDataPoints = snapshot.points
        }
        .onPreferenceChange(ChartXRangePreferenceKey.self) { range in
            preferredXRange = range
        }
        .onPreferenceChange(ChartXDomainModePreferenceKey.self) { mode in
            preferredXDomainMode = mode
        }
    }

    @ViewBuilder
    private func positionedXLabel(_ xLabel: ChartXAxisLabel, width: CGFloat) -> some View {
        let normalized = xScale.normalizedX(for: xLabel.value)
        let clamped = min(1.0, max(0.0, normalized))

        if clamped <= 0.001 {
            Text(xLabel.title)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .font(axisConfig.axisFont)
                .foregroundColor(axisConfig.axisFontColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        } else if clamped >= 0.999 {
            Text(xLabel.title)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .font(axisConfig.axisFont)
                .foregroundColor(axisConfig.axisFontColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        } else {
            Text(xLabel.title)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .font(axisConfig.axisFont)
                .foregroundColor(axisConfig.axisFontColor)
                .position(x: width * CGFloat(clamped), y: xAxisHeight / 2)
        }
    }
}
