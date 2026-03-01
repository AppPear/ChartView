import SwiftUI

public struct BarChartRow: View {
    @Environment(\.chartInteractionValue) private var chartValue

    var chartData: ChartData
    @State private var touchLocation: CGFloat = -1.0

    var style: ChartStyle

    public var body: some View {
        GeometryReader { geometry in
            let localFrame = geometry.frame(in: .local).sanitized
            let safeWidth = localFrame.width
            let safeHeight = localFrame.height
            let barCount = max(1, chartData.data.count)
            let slotWidth = safeWidth / CGFloat(barCount)
            let barWidthRatio: CGFloat = 0.72

            HStack(alignment: .bottom, spacing: 0) {
                ForEach(0..<chartData.data.count, id: \.self) { index in
                    BarChartCell(value: chartData.normalisedPoints[index],
                                 index: index,
                                 gradientColor: style.foregroundColor.rotate(for: index),
                                 touchLocation: touchLocation)
                        .frame(width: slotWidth * barWidthRatio)
                        .scaleEffect(getScaleSize(touchLocation: touchLocation, index: index), anchor: .bottom)
                        .animation(Animation.easeIn(duration: 0.2))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
            }
            .frame(width: safeWidth,
                   height: chartData.isInNegativeDomain ? safeHeight / 2 : safeHeight,
                   alignment: .bottomLeading)
            .gesture(DragGesture()
                .onChanged({ value in
                    let width = safeWidth
                    guard width > 0 else { return }
                    touchLocation = value.location.x / width
                    if let currentValue = getCurrentValue(width: width), let interactionValue = chartValue {
                        interactionValue.currentValue = currentValue
                        interactionValue.interactionInProgress = true
                    }
                })
                .onEnded({ _ in
                    chartValue?.interactionInProgress = false
                    touchLocation = -1
                })
            )
        }
    }

    func getScaleSize(touchLocation: CGFloat, index: Int) -> CGSize {
        if touchLocation > CGFloat(index) / CGFloat(max(1, chartData.data.count)) &&
            touchLocation < CGFloat(index + 1) / CGFloat(max(1, chartData.data.count)) {
            return CGSize(width: 1.4, height: 1.1)
        }
        return CGSize(width: 1, height: 1)
    }

    func getCurrentValue(width: CGFloat) -> Double? {
        guard !chartData.data.isEmpty else { return nil }
        guard width.isFinite, width > 0 else { return nil }
        let denominator = width / CGFloat(chartData.data.count)
        guard denominator > 0, denominator.isFinite else { return nil }
        let index = max(0, min(chartData.data.count - 1, Int(floor((touchLocation * width) / denominator))))
        return chartData.points[index]
    }
}

struct BarChartRow_Previews: PreviewProvider {
    static let chartData = ChartData([6, 2, 5, 8, 6])
    static let chartStyle = ChartStyle(backgroundColor: .white, foregroundColor: .orangeBright)

    static var previews: some View {
        BarChartRow(chartData: chartData, style: chartStyle)
    }
}
