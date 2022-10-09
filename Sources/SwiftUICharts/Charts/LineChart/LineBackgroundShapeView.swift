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
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}
