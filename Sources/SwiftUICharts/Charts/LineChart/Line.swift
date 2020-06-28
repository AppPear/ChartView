import SwiftUI

public struct Line: View {
    @Environment(\.chartValue) private var chartValue: ChartValue
    @State var frame: CGRect = .zero
    @ObservedObject var chartData: ChartData

    var style: ChartStyle

    @State var showIndicator: Bool = false
    @State var touchLocation: CGPoint = .zero
    @State private var showFull: Bool = false
    @State var showBackground: Bool = true
    var curvedLines: Bool = true
    var step: CGPoint {
        return CGPoint.getStep(frame: frame, data: chartData.data)
    }

    var path: Path {
        let points = chartData.data

        if curvedLines {
            return Path.quadCurvedPathWithPoints(points: points,
                                                 step: step,
                                                 globalOffset: nil)
        }

        return Path.linePathWithPoints(points: points, step: step)
    }
    
    var closedPath: Path {
        let points = chartData.data

        if curvedLines {
            return Path.quadClosedCurvedPathWithPoints(points: points,
                                            step: step,
                                            globalOffset: nil)
        }

        return Path.closedLinePathWithPoints(points: points, step: step)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.showFull && self.showBackground {
                    self.getBackgroundPathView()
                }
                self.getLinePathView()
                if self.showIndicator {
                    IndicatorPoint()
                        .position(self.getClosestPointOnPath(touchLocation: self.touchLocation))
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
            }
            .onAppear {
                self.frame = geometry.frame(in: .local)
            }
            .gesture(DragGesture()
                .onChanged({ value in
                    self.touchLocation = value.location
                    self.showIndicator = true
                    self.getClosestDataPoint(point: self.getClosestPointOnPath(touchLocation: value.location))
                    self.chartValue.interactionInProgress = true
                })
                .onEnded({ value in
                    self.touchLocation = .zero
                    self.showIndicator = false
                    self.chartValue.interactionInProgress = false
                })
            )
        }
    }
}

// MARK: - Private functions

extension Line {
    private func getClosestPointOnPath(touchLocation: CGPoint) -> CGPoint {
        let closest = self.path.point(to: touchLocation.x)
        return closest
    }

    private func getClosestDataPoint(point: CGPoint) {
        let index = Int(round((point.x)/step.x))
        if (index >= 0 && index < self.chartData.data.count){
            self.chartValue.currentValue = self.chartData.data[index]
        }
    }

    private func getBackgroundPathView() -> some View {
        self.closedPath
            .fill(style.backgroundColor.linearGradient(from: .bottom, to: .top))
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .transition(.opacity)
            .animation(.easeIn(duration: 1.6))
    }

    private func getLinePathView() -> some View {
        self.path
            .trim(from: 0, to: self.showFull ? 1:0)
            .stroke(LinearGradient(gradient: style.foregroundColor.first?.gradient ?? ColorGradient.orangeBright.gradient,
                                   startPoint: .leading,
                                   endPoint: .trailing),
                    style: StrokeStyle(lineWidth: 3, lineJoin: .round))
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .animation(Animation.easeOut(duration: 1.2))
            .onAppear {
                self.showFull = true
            }
            .onDisappear {
                self.showFull = false
            }
            .drawingGroup()
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Line(chartData:  ChartData([8, 23, 32, 7, 23, 43]), style: blackLineStyle)
            Line(chartData:  ChartData([8, 23, 32, 7, 23, 43]), style: redLineStyle)
        }
    }
}

private let blackLineStyle = ChartStyle(backgroundColor: ColorGradient(.white), foregroundColor: ColorGradient(.black))
private let redLineStyle = ChartStyle(backgroundColor: .whiteBlack, foregroundColor: ColorGradient(.red))
