import SwiftUI

struct LineBackgroundShape: Shape {
    var data: [Double]
    func path(in rect: CGRect) -> Path {
        let path = Path.quadClosedCurvedPathWithPoints(points: data, step: CGPoint(x: 1.0, y: 1.0))
        return path
    }
}

struct LineBackgroundShape_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GeometryReader { geometry in
                LineBackgroundShape(data: [0, 0.5, 0.8, 0.6, 1])
                    .transform(CGAffineTransform(scaleX: geometry.size.width / 4.0, y: geometry.size.height))
                    .fill(Color.red)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            GeometryReader { geometry in
                LineBackgroundShape(data: [0, -0.5, 0.8, -0.6, 1])
                    .transform(CGAffineTransform(scaleX: geometry.size.width / 4.0, y: geometry.size.height / 1.6))
                    .fill(Color.blue)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
    }
}

