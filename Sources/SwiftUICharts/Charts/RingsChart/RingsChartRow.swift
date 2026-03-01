import SwiftUI

public struct RingsChartRow: View {
    var width: CGFloat
    var spacing: CGFloat

    @Environment(\.chartInteractionValue) private var chartValue
    var chartData: ChartData
    @State var touchRadius: CGFloat = -1.0

    var style: ChartStyle

    public var body: some View {
        GeometryReader { geometry in
            let safeSize = geometry.size.sanitized
            ZStack {
                Circle()
                    .fill(RadialGradient(gradient: style.backgroundColor.gradient,
                                         center: .center,
                                         startRadius: min(safeSize.width, safeSize.height) / 2.0,
                                         endRadius: 1.0))

                ForEach(0..<chartData.data.count, id: \.self) { index in
                    let scaleUp = isRingScaled(size: safeSize, touchRadius: touchRadius, index: index)
                    let scaledWidth = scaleUp ? width * 2.0 : width

                    let normalPadding = (width + spacing) * CGFloat(index)
                    let scaledDiff = (scaledWidth - width) / 2.0
                    let padding = min(normalPadding - scaledDiff,
                                      min(safeSize.width, safeSize.height) / 2.0 - width)

                    Ring(ringWidth: scaledWidth,
                         percent: chartData.points[index],
                         foregroundColor: style.foregroundColor.rotate(for: index),
                         touchLocation: touchRadius)
                        .zIndex(scaleUp ? 1 : 0)
                        .padding(padding)
                        .animation(Animation.easeIn(duration: 0.5))
                }
            }
            .frame(width: safeSize.width, height: safeSize.height, alignment: .topLeading)
            .gesture(DragGesture()
                .onChanged({ value in
                    let frame = geometry.frame(in: .local).sanitized
                    let radius = min(frame.width, frame.height) / 2.0
                    let deltaX = value.location.x - frame.midX
                    let deltaY = value.location.y - frame.midY
                    touchRadius = sqrt(deltaX * deltaX + deltaY * deltaY)

                    if let currentValue = getCurrentValue(maxRadius: radius), let interactionValue = chartValue {
                        interactionValue.currentValue = currentValue
                        interactionValue.interactionInProgress = true
                    }
                })
                .onEnded({ _ in
                    chartValue?.interactionInProgress = false
                    touchRadius = -1
                })
            )
        }
    }

    func isRingScaled(size: CGSize, touchRadius: CGFloat, index: Int) -> Bool {
        let radius = min(size.width, size.height) / 2.0
        return index == touchedCircleIndex(maxRadius: radius)
    }

    func touchedCircleIndex(maxRadius: CGFloat) -> Int? {
        guard !chartData.data.isEmpty else { return nil }

        let radialDistanceFromEdge = (maxRadius + spacing / 2) - touchRadius
        guard radialDistanceFromEdge >= 0 else { return nil }

        let touchIndex = Int(floor(radialDistanceFromEdge / (width + spacing)))

        if touchIndex >= chartData.data.count { return nil }

        return touchIndex
    }

    func getCurrentValue(maxRadius: CGFloat) -> Double? {
        guard let index = touchedCircleIndex(maxRadius: maxRadius) else { return nil }
        return chartData.points[index]
    }
}

struct RingsChartRow_Previews: PreviewProvider {
    static var previews: some View {
        let multiStyle = ChartStyle(backgroundColor: ColorGradient(Color.black.opacity(0.05), Color.white),
                                    foregroundColor: [ColorGradient(.purple, .blue),
                                                      ColorGradient(.orange, .red),
                                                      ColorGradient(.green, .yellow)])

        return RingsChartRow(width: 20.0,
                             spacing: 10.0,
                             chartData: ChartData([25, 50, 75, 100, 125]),
                             style: multiStyle)
            .frame(width: 300, height: 400)
    }
}
