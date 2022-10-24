import SwiftUI

struct LineShapeView: View, Animatable {
    var chartData: ChartData
    var chartProperties: LineChartProperties

    var geometry: GeometryProxy
    var style: ChartStyle
    var trimTo: Double = 0

    var animatableData: CGFloat {
        get { CGFloat(trimTo) }
        set { trimTo = Double(newValue) }
    }

    var chartMarkColor: LinearGradient {
        if let customColor = chartProperties.customChartMarksColors {
            return customColor.linearGradient(from: .leading, to: .trailing)
        }

        return LinearGradient(gradient: style.foregroundColor.first?.gradient ?? ColorGradient.orangeBright.gradient,
                              startPoint: .leading,
                              endPoint: .trailing)
    }

    var body: some View {
        ZStack {
            LineShape(data: chartData.normalisedData, lineStyle: chartProperties.lineStyle)
                .trim(from: 0, to: CGFloat(trimTo))
                .stroke(LinearGradient(gradient: style.foregroundColor.first?.gradient ?? ColorGradient.orangeBright.gradient,
                                       startPoint: .leading,
                                       endPoint: .trailing),
                        style: StrokeStyle(lineWidth: chartProperties.lineWidth, lineJoin: .round))
                .toStandardCoordinateSystem()
                .clipped()
            if chartProperties.showChartMarks {
                MarkerShape(data: chartData.normalisedData)
                    .trim(from: 0, to: CGFloat(trimTo))
                    .fill(.white,
                          strokeBorder: chartMarkColor,
                          lineWidth: chartProperties.lineWidth)
                    .toStandardCoordinateSystem()
            }
        }
    }
}

struct LineShapeView_Previews: PreviewProvider {
    static let chartData = ChartData([6, 8, 6], rangeY: 6...10)
    static let chartDataOutOfRange = ChartData([-1, 8, 6, 12, 3], rangeY: -5...15)

    static let chartDataOutOfRange2 = ChartData([6,6,8,5], rangeY: 5...10)

    static let chartStyle = ChartStyle(backgroundColor: Color.white,
                                       foregroundColor: [ColorGradient(Color.orange, Color.red)])
    static var previews: some View {
        Group {
            GeometryReader { geometry in
                LineShapeView(chartData: chartData,
                              chartProperties: LineChartProperties(),
                              geometry: geometry,
                              style: chartStyle,
                              trimTo: 1.0)
            }
            GeometryReader { geometry in
                LineShapeView(chartData: chartDataOutOfRange,
                              chartProperties: LineChartProperties(),
                              geometry: geometry,
                              style: chartStyle,
                              trimTo: 1.0)
            }
            GeometryReader { geometry in
                LineShapeView(chartData: chartDataOutOfRange2,
                              chartProperties: LineChartProperties(),
                              geometry: geometry,
                              style: chartStyle,
                              trimTo: 1.0)
            }
        }
    }
}


