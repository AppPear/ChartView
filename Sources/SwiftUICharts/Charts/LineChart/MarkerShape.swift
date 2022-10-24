import SwiftUI

struct MarkerShape: Shape {
    var data: [(Double, Double)]
    func path(in rect: CGRect) -> Path {
        let path = Path.drawChartMarkers(data: data, in: rect)
        return path
    }
}

struct MarkerShape_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MarkerShape(data: [(0, 0), (0.25, 0.5), (0.5,0.8), (0.75, 0.6), (1, 1)])
                .stroke()
                .toStandardCoordinateSystem()

            MarkerShape(data: [(0, -0.5), (0.25, 0.8), (0.5,-0.6), (0.75,0.6), (1, 1)])
                .stroke()
                .toStandardCoordinateSystem()
        }
    }
}
