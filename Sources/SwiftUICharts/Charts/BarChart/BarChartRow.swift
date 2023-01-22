import SwiftUI

public struct BarChartRow: View {
    @EnvironmentObject var chartValue: ChartValue
    @ObservedObject var chartData: ChartData
    @State private var touchLocation: CGFloat = -1.0

    var style: ChartStyle
    
    var maxValue: Double {
        guard let max = chartData.points.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }

    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom,
                   spacing: geometry.frame(in: .local).width / CGFloat(chartData.data.count * 3)) {
                    ForEach(0..<chartData.data.count, id: \.self) { index in
                        BarChartCell(value: chartData.normalisedPoints[index],
                                     index: index,
                                     gradientColor: self.style.foregroundColor.rotate(for: index),
                                     touchLocation: self.touchLocation)
                            .scaleEffect(self.getScaleSize(touchLocation: self.touchLocation, index: index), anchor: .bottom)
                            .animation(Animation.easeIn(duration: 0.2))
                    }
//                    .drawingGroup()
            }
            .frame(maxHeight: chartData.isInNegativeDomain ? geometry.size.height / 2 : geometry.size.height)
            .gesture(DragGesture()
                .onChanged({ value in
                    let width = geometry.frame(in: .local).width
                    self.touchLocation = value.location.x/width
                    if let currentValue = self.getCurrentValue(width: width) {
                        self.chartValue.currentValue = currentValue
                        self.chartValue.interactionInProgress = true
                    }
                })
                .onEnded({ value in
                    self.chartValue.interactionInProgress = false
                    self.touchLocation = -1
                })
            )
        }
    }

    func getScaleSize(touchLocation: CGFloat, index: Int) -> CGSize {
        if touchLocation > CGFloat(index)/CGFloat(chartData.data.count) &&
           touchLocation < CGFloat(index+1)/CGFloat(chartData.data.count) {
            return CGSize(width: 1.4, height: 1.1)
        }
        return CGSize(width: 1, height: 1)
    }

    func getCurrentValue(width: CGFloat) -> Double? {
        guard self.chartData.data.count > 0 else { return nil}
            let index = max(0,min(self.chartData.data.count-1,Int(floor((self.touchLocation*width)/(width/CGFloat(self.chartData.data.count))))))
            return self.chartData.points[index]
        }
}

struct BarChartRow_Previews: PreviewProvider {
    static let chartData = ChartData([6, 2, 0, 8, 6])
    static let chartStyle = ChartStyle(backgroundColor: .white, foregroundColor: .orangeBright)
    static var previews: some View {
        BarChartRow(chartData: chartData, style: chartStyle)
    }
}
