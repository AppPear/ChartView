import SwiftUI

/// A single row of data, a view in a `BarChart`
public struct BarChartRow<Root: ChartDataPoint, ChartValueType: ChartValue>: View where ChartValueType.Root == Root {
    @EnvironmentObject var chartValue: ChartValueType
    @ObservedObject var chartData: ChartData<Root>
    @State private var touchLocation: CGFloat = -1.0

    var style: ChartStyle
    
    var maxValue: Double {
        guard let max = chartData.points.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }

	/// The content and behavior of the `BarChartRow`.
	///
	/// Shows each `BarChartCell` in an `HStack`; may be scaled up if it's the one currently being touched.
	/// Not using a drawing group for optimizing animation.
	/// As touched (dragged) the `touchLocation` is updated and the current value is highlighted.
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

	/// Size to scale the touch indicator
	/// - Parameters:
	///   - touchLocation: fraction of width where touch is happening
	///   - index: index into data array
	/// - Returns: a scale larger than 1.0 if in bounds; 1.0 (unscaled) if not in bounds
    func getScaleSize(touchLocation: CGFloat, index: Int) -> CGSize {
        if touchLocation > CGFloat(index)/CGFloat(chartData.data.count) &&
           touchLocation < CGFloat(index+1)/CGFloat(chartData.data.count) {
            return CGSize(width: 1.4, height: 1.1)
        }
        return CGSize(width: 1, height: 1)
    }

	/// Get data value where touch happened
	/// - Parameter width: width of chart
	/// - Returns: value as `Double` if chart has data
    func getCurrentValue(width: CGFloat) -> Root? {
        guard self.chartData.data.count > 0 else { return nil}
            let index = max(0,min(self.chartData.data.count-1,Int(floor((self.touchLocation*width)/(width/CGFloat(self.chartData.data.count))))))
            return self.chartData.data[index]
        }
}

struct BarChartRow_Previews: PreviewProvider {
    static let chartData = ChartData([6, 2, 5, 8, 6])
    static let chartStyle = ChartStyle(backgroundColor: .white, foregroundColor: .orangeBright)
    static var previews: some View {
        BarChartRow<SimpleChartDataPoint, SimpleChartValue>(chartData: chartData, style: chartStyle)
    }
}
