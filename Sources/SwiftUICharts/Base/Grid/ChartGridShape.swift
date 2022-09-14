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
                .rotationEffect(.degrees(180), anchor: .center)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))

            ChartGridShape(numberOfHorizontalLines: 4, numberOfVerticalLines: 4)
                .stroke()
                .rotationEffect(.degrees(180), anchor: .center)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .padding()
    }
}
