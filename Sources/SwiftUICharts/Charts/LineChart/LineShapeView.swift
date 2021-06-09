import SwiftUI

struct LineShapeView: View, Animatable {
    var chartData: ChartData
    var geometry: GeometryProxy
    var style: ChartStyle
    var trimTo: Double = 0

    var animatableData: CGFloat {
        get { CGFloat(trimTo) }
        set { trimTo = Double(newValue) }
    }

    var body: some View {
        LineShape(data: chartData.normalisedPoints)
            .trim(from: 0, to: CGFloat(trimTo))
            .transform(CGAffineTransform(scaleX: geometry.size.width / CGFloat(chartData.normalisedPoints.count - 1),
                                         y: geometry.size.height / CGFloat(chartData.normalisedRange)))
            .stroke(LinearGradient(gradient: style.foregroundColor.first?.gradient ?? ColorGradient.orangeBright.gradient,
                                   startPoint: .leading,
                                   endPoint: .trailing),
                    style: StrokeStyle(lineWidth: 3, lineJoin: .round))
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}
