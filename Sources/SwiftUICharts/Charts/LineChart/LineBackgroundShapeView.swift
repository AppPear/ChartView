import SwiftUI

struct LineBackgroundShapeView: View {
    var chartData: ChartData
    var geometry: GeometryProxy
    var backgroundColor: ColorGradient

    var body: some View {
        LineBackgroundShape(data: chartData.normalisedData)
            .fill(LinearGradient(gradient: Gradient(colors: [backgroundColor.startColor,
                                                             backgroundColor.endColor]),
                                 startPoint: .bottom,
                                 endPoint: .top))
            .toStandardCoordinateSystem()
    }
}
