import SwiftUI

public struct AxisLabels<Content: View>: View {
    struct YAxisViewKey: ViewPreferenceKey { }
    struct ChartViewKey: ViewPreferenceKey { }

    var axisLabelsData = AxisLabelsData()
    var axisLabelsStyle = AxisLabelsStyle()

    @State private var yAxisWidth: CGFloat = 25
    @State private var chartWidth: CGFloat = 0
    @State private var chartHeight: CGFloat = 0

    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var yAxis: some View {
        VStack(spacing: 0.0) {
            ForEach(Array(axisLabelsData.axisYLabels.reversed().enumerated()), id: \.element) { index, axisYData in
                Text(axisYData)
                    .font(axisLabelsStyle.axisFont)
                    .foregroundColor(axisLabelsStyle.axisFontColor)
                    .frame(height: getYHeight(index: index,
                                              chartHeight: chartHeight,
                                              count: axisLabelsData.axisYLabels.count),
                           alignment: getYAlignment(index: index, count: axisLabelsData.axisYLabels.count))
            }
        }
        .padding([.leading, .trailing], 4.0)
        .background(ViewGeometry<YAxisViewKey>())
        .onPreferenceChange(YAxisViewKey.self) { value in
            yAxisWidth = value.first?.size.width ?? 0.0
        }
    }

    func xAxis(chartWidth: CGFloat) -> some View {
        HStack(spacing: 0.0) {
            ForEach(Array(axisLabelsData.axisXLabels.enumerated()), id: \.element) { index, axisXData in
                Text(axisXData)
                    .font(axisLabelsStyle.axisFont)
                    .foregroundColor(axisLabelsStyle.axisFontColor)
                    .frame(width: chartWidth / CGFloat(axisLabelsData.axisXLabels.count - 1))
            }
        }
        .frame(height: 24.0, alignment: .top)
    }

    var chart: some View {
        self.content()
            .background(ViewGeometry<ChartViewKey>())
            .onPreferenceChange(ChartViewKey.self) { value in
                chartWidth = value.first?.size.width ?? 0.0
                chartHeight = value.first?.size.height ?? 0.0
            }
    }

    public var body: some View {
        VStack(spacing: 4.0) {
            HStack {
                if axisLabelsStyle.axisLabelsYPosition == .leading {
                    yAxis
                } else {
                    Spacer(minLength: yAxisWidth)
                }
                chart
                if axisLabelsStyle.axisLabelsYPosition == .leading {
                    Spacer(minLength: yAxisWidth)
                } else {
                    yAxis
                }
            }
            xAxis(chartWidth: chartWidth)
        }
    }

    private func getYHeight(index: Int, chartHeight: CGFloat, count: Int) -> CGFloat {
        if index == 0 || index == count - 1 {
            return chartHeight / (CGFloat(count - 1) * 2) + 10
        }

        return chartHeight / CGFloat(count - 1)
    }

    private func getYAlignment(index: Int, count: Int) -> Alignment {
        if index == 0 {
            return .top
        }

        if index == count - 1 {
            return .bottom
        }

        return .center
    }
}
