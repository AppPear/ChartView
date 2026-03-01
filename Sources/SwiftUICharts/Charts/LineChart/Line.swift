import SwiftUI

/// A single line of data, a view in a `LineChart`
public struct Line: View {
    var chartData: ChartData
    var chartProperties: ChartLineConfig

    var style: ChartStyle

    @State private var didCellAppear: Bool = false

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
            }
            .frame(width: safeFrame.width, height: safeFrame.height, alignment: .topLeading)
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
