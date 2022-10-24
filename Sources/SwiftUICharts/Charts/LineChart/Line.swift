import SwiftUI

/// A single line of data, a view in a `LineChart`
public struct Line: View {
    @ObservedObject var chartData: ChartData
    @ObservedObject var chartProperties: LineChartProperties

    var curvedLines: Bool = true
    var style: ChartStyle

    @State private var showIndicator: Bool = false
    @State private var touchLocation: CGPoint = .zero
    @State private var didCellAppear: Bool = false

    var path: Path {
        Path.quadCurvedPathWithPoints(points: chartData.normalisedPoints,
                                      step: CGPoint(x: 1.0, y: 1.0))
    }

    public init(chartData: ChartData,
                style: ChartStyle,
                chartProperties: LineChartProperties) {
        self.chartData = chartData
        self.style = style
        self.chartProperties = chartProperties
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.didCellAppear, let backgroundColor = chartProperties.backgroundGradient {
                    LineBackgroundShapeView(chartData: chartData,
                                            geometry: geometry,
                                            backgroundColor: backgroundColor)
                }
                LineShapeView(chartData: chartData,
                              chartProperties: chartProperties,
                              geometry: geometry,
                              style: style,
                              trimTo: didCellAppear ? 1.0 : 0.0)
                .animation(Animation.easeIn(duration: 0.75))
                if self.showIndicator {
                    IndicatorPoint()
                        .position(self.getClosestPointOnPath(geometry: geometry,
                                                             touchLocation: self.touchLocation))
                        .toStandardCoordinateSystem()
                }
            }
            .onAppear {
                didCellAppear = true
            }
            .onDisappear() {
                didCellAppear = false
            }
//            .gesture(DragGesture()
//                .onChanged({ value in
//                    self.touchLocation = value.location
//                    self.showIndicator = true
//                    self.getClosestDataPoint(geometry: geometry, touchLocation: value.location)
//                })
//                .onEnded({ value in
//                    self.touchLocation = .zero
//                    self.showIndicator = false
//                })
//            )
        }
    }
}

// MARK: - Private functions

extension Line {
	/// Calculate point closest to where the user touched
	/// - Parameter touchLocation: location in view where touched
	/// - Returns: `CGPoint` of data point on chart
    private func getClosestPointOnPath(geometry: GeometryProxy, touchLocation: CGPoint) -> CGPoint {
        let geometryWidth = geometry.frame(in: .local).width
        let normalisedTouchLocationX = (touchLocation.x / geometryWidth) * CGFloat(chartData.normalisedPoints.count - 1)
        let closest = self.path.point(to: normalisedTouchLocationX)
        var denormClosest = closest.denormalize(with: geometry)
        denormClosest.x = denormClosest.x / CGFloat(chartData.normalisedPoints.count - 1)
        denormClosest.y = denormClosest.y / CGFloat(chartData.normalisedYRange)
        return denormClosest
    }

//	/// Figure out where closest touch point was
//	/// - Parameter point: location of data point on graph, near touch location
    private func getClosestDataPoint(geometry: GeometryProxy, touchLocation: CGPoint) {
        let geometryWidth = geometry.frame(in: .local).width
        let index = Int(round((touchLocation.x / geometryWidth) * CGFloat(chartData.points.count - 1)))
        if (index >= 0 && index < self.chartData.data.count){
//            self.chartValue.currentValue = self.chartData.points[index]
        }
    }
}

struct Line_Previews: PreviewProvider {
    /// Predefined style, black over white, for preview
    static let blackLineStyle = ChartStyle(backgroundColor: ColorGradient(.white), foregroundColor: ColorGradient(.black))

    /// Predefined style red over white, for preview
    static let redLineStyle = ChartStyle(backgroundColor: .whiteBlack, foregroundColor: ColorGradient(.red))

    static var previews: some View {
        Group {
            Line(chartData: ChartData([8, 23, 32, 7, 23, -4]),
                 style: blackLineStyle,
                 chartProperties: LineChartProperties())
            Line(chartData:  ChartData([8, 23, 32, 7, 23, 43]),
                 style: redLineStyle,
                 chartProperties: LineChartProperties())
        }
    }
}

