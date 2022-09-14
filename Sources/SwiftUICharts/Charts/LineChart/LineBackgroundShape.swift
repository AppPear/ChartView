import SwiftUI

struct LineBackgroundShape: Shape {
    var data: [(Double, Double)]
    func path(in rect: CGRect) -> Path {
        let path = Path.quadClosedCurvedPathWithPoints(data: data, in: rect)
        return path
    }
}

struct LineBackgroundShape_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GeometryReader { geometry in
                LineBackgroundShape(data: [(0, -0.5), (0.25, 0.8), (0.5,-0.6), (0.75,0.6), (1, 1)])
                    .fill(Color.red)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            GeometryReader { geometry in
                LineBackgroundShape(data: [(0, 0), (0.25, 0.5), (0.5,0.8), (0.75, 0.6), (1, 1)])
                    .fill(Color.blue)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
    }
}

