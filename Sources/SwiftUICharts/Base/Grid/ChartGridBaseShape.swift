import SwiftUI

struct ChartGridBaseShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct ChartGridBaseShape_Previews: PreviewProvider {
    static var previews: some View {
        ChartGridBaseShape()
            .stroke()
            .rotationEffect(.degrees(180), anchor: .center)
    }
}
