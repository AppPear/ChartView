import SwiftUI

struct ChartGridShape: Shape {
    var numberOfHorizontalLines: Int
    var numberOfVerticalLines: Int

    func path(in rect: CGRect) -> Path {
        let path = Path.drawGridLines(numberOfHorizontalLines: numberOfHorizontalLines,
                                      numberOfVerticalLines: numberOfVerticalLines,
                                      in: rect)
        return path
    }
}

struct ChartGridShape_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChartGridShape(numberOfHorizontalLines: 5, numberOfVerticalLines: 0)
                .stroke()
                .toStandardCoordinateSystem()

            ChartGridShape(numberOfHorizontalLines: 4, numberOfVerticalLines: 4)
                .stroke()
                .toStandardCoordinateSystem()
        }
        .padding()
    }
}
