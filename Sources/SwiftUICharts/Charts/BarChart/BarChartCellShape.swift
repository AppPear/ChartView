import SwiftUI

struct BarChartCellShape: Shape, Animatable {
    var value: Double
    var cornerRadius: CGFloat = 6.0
    
    var animatableData: CGFloat {
        get { CGFloat(value) }
        set { value = Double(newValue) }
    }

    func path(in rect: CGRect) -> Path {
        let adjustedOriginY = rect.height - (rect.height * CGFloat(value))
        var path = Path()
        guard value != 0 else {
            return path
        }
        path.move(to: CGPoint(x: 0.0 , y: rect.height))
        path.addLine(to: CGPoint(x: 0.0, y: adjustedOriginY + cornerRadius))
        path.addArc(center: CGPoint(x: cornerRadius, y: adjustedOriginY +  cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(radians: Double.pi),
                    endAngle: Angle(radians: value < 0 ? Double.pi/2 : -Double.pi/2),
                    clockwise: value < 0 ? true : false)
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: value < 0 ? adjustedOriginY + 2 * cornerRadius : adjustedOriginY))
        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: adjustedOriginY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(radians: value < 0 ? Double.pi/2 : -Double.pi/2),
                    endAngle: Angle(radians: 0),
                    clockwise: value < 0 ? true : false)
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()

        return path
    }
}

struct BarChartCellShape_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BarChartCellShape(value: 0.75)
                .fill(Color.red)

            BarChartCellShape(value: 0.3)
                .fill(Color.blue)

            BarChartCellShape(value: 0)
                .fill(Color.blue)
                .padding(50)
            
            BarChartCellShape(value: -0.3)
                .fill(Color.blue)
                .offset(x: 0, y: -600)
        }
    }
}
