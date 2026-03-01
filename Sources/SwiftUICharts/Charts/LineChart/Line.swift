import SwiftUI

/// A single line of data, a view in a `LineChart`
public struct Line: View {
    @Environment(\.chartInteractionValue) private var chartValue

    var chartData: ChartData
    var chartProperties: ChartLineConfig

    var style: ChartStyle

    @State private var didCellAppear: Bool = false
    @State private var touchLocation: CGFloat = -1

    public init(chartData: ChartData,
                style: ChartStyle,
                chartProperties: ChartLineConfig) {
        self.chartData = chartData
        self.style = style
        self.chartProperties = chartProperties
    }

    public var body: some View {
        GeometryReader { geometry in
            let safeFrame = geometry.frame(in: .local).sanitized
            ZStack {
                if didCellAppear, let backgroundColor = chartProperties.backgroundGradient {
                    LineBackgroundShapeView(chartData: chartData,
                                            geometry: geometry,
                                            backgroundColor: backgroundColor)
                }
                lineShapeView(geometry: geometry)
                selectionOverlay(size: safeFrame.size)
                accessibilityOverlay(size: safeFrame.size)
            }
            .frame(width: safeFrame.width, height: safeFrame.height, alignment: .topLeading)
            .contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    guard safeFrame.width > 0 else { return }
                    touchLocation = max(0, min(1, value.location.x / safeFrame.width))
                    publishSelectionState(active: true)
                })
                .onEnded({ _ in
                    publishSelectionState(active: false)
                    touchLocation = -1
                }))
            .onAppear {
                didCellAppear = true
            }
            .onDisappear {
                didCellAppear = false
            }
        }
    }

    @ViewBuilder
    private func lineShapeView(geometry: GeometryProxy) -> some View {
        if chartProperties.animationEnabled {
            LineShapeView(chartData: chartData,
                          chartProperties: chartProperties,
                          geometry: geometry,
                          style: style,
                          trimTo: didCellAppear ? 1.0 : 0.0)
                .animation(Animation.easeIn(duration: 0.75))
        } else {
            LineShapeView(chartData: chartData,
                          chartProperties: chartProperties,
                          geometry: geometry,
                          style: style,
                          trimTo: 1.0)
        }
    }

    @ViewBuilder
    private func selectionOverlay(size: CGSize) -> some View {
        if chartValue != nil,
           touchLocation >= 0,
           let selectedPoint = selectedChartPoint(size: size) {
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: selectedPoint.x, y: 0))
                    path.addLine(to: CGPoint(x: selectedPoint.x, y: size.height))
                }
                .stroke(style.foregroundColor.rotate(for: selectedPoint.index).startColor.opacity(0.28),
                        style: StrokeStyle(lineWidth: 1, dash: [4, 4]))

                IndicatorPoint()
                    .position(x: selectedPoint.x, y: selectedPoint.y)
            }
            .toStandardCoordinateSystem()
        }
    }

    @ViewBuilder
    private func accessibilityOverlay(size: CGSize) -> some View {
        if !chartData.normalisedData.isEmpty {
            ZStack {
                ForEach(Array(chartData.normalisedData.enumerated()), id: \.offset) { index, point in
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 30, height: 30)
                        .position(x: CGFloat(point.0) * size.width,
                                  y: CGFloat(point.1) * size.height)
                        .accessibilityElement(children: .ignore)
                        .accessibility(label: Text("Point \(index + 1), value \(formatted(chartData.points[index]))"))
                }
            }
            .toStandardCoordinateSystem()
            .allowsHitTesting(false)
        }
    }

    private func selectedIndex() -> Int? {
        guard !chartData.normalisedData.isEmpty, touchLocation >= 0 else { return nil }

        return chartData.normalisedData.enumerated().min {
            abs($0.element.0 - Double(touchLocation)) < abs($1.element.0 - Double(touchLocation))
        }?.offset
    }

    private func selectedChartPoint(size: CGSize) -> (index: Int, x: CGFloat, y: CGFloat)? {
        guard let index = selectedIndex(),
              index < chartData.normalisedData.count else {
            return nil
        }

        let point = chartData.normalisedData[index]
        return (index, CGFloat(point.0) * size.width, CGFloat(point.1) * size.height)
    }

    private func publishSelectionState(active: Bool) {
        guard let interactionValue = chartValue else { return }

        interactionValue.interactionInProgress = active
        if active, let index = selectedIndex(), index < chartData.points.count {
            interactionValue.currentValue = chartData.points[index]
        }
    }

    private func formatted(_ value: Double) -> String {
        if abs(value.rounded() - value) < 0.001 {
            return String(Int(value.rounded()))
        }
        return String(format: "%.2f", value)
    }
}

struct Line_Previews: PreviewProvider {
    static let blackLineStyle = ChartStyle(backgroundColor: ColorGradient(.white), foregroundColor: ColorGradient(.black))
    static let redLineStyle = ChartStyle(backgroundColor: .whiteBlack, foregroundColor: ColorGradient(.red))

    static var previews: some View {
        Group {
            Line(chartData: ChartData([8, 23, 32, 7, 23, -4]),
                 style: blackLineStyle,
                 chartProperties: ChartLineConfig())
            Line(chartData: ChartData([8, 23, 32, 7, 23, 43]),
                 style: redLineStyle,
                 chartProperties: ChartLineConfig())
        }
    }
}
