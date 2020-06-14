import SwiftUI

public struct BarChartCell: View {
    var value: Double
    var index: Int = 0
    var width: Float
    var numberOfDataPoints: Int
    var gradientColor: ColorGradient
    var touchLocation: CGFloat

    var cellWidth: Double {
        return Double(width)/(Double(numberOfDataPoints) * 1.5)
    }

    @State var scaleValue: Double = 0

    public init( value: Double,
                 index: Int = 0,
                 width: Float,
                 numberOfDataPoints: Int,
                 gradientColor: ColorGradient,
                 touchLocation: CGFloat) {
        self.value = value
        self.index = index
        self.width = width
        self.numberOfDataPoints = numberOfDataPoints
        self.gradientColor = gradientColor
        self.touchLocation = touchLocation
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(gradientColor.linearGradient(from: .bottom, to: .top))
            }
            .frame(width: CGFloat(self.cellWidth))
            .scaleEffect(CGSize(width: 1, height: self.value), anchor: .bottom)
            .onAppear {
                self.scaleValue = self.value
            }
        .animation(Animation.spring().delay(self.touchLocation < 0 ?  Double(self.index) * 0.04 : 0))
    }
}

struct BarChartCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                BarChartCell(value: 0, width: 50, numberOfDataPoints: 1, gradientColor: ColorGradient.greenRed, touchLocation: CGFloat())

                BarChartCell(value: 1, width: 50, numberOfDataPoints: 1, gradientColor: ColorGradient.greenRed, touchLocation: CGFloat())
                BarChartCell(value: 1, width: 50, numberOfDataPoints: 1, gradientColor: ColorGradient.whiteBlack, touchLocation: CGFloat())
                BarChartCell(value: 1, width: 50, numberOfDataPoints: 1, gradientColor: ColorGradient(.purple), touchLocation: CGFloat())
            }

            Group {
                BarChartCell(value: 1, width: 50, numberOfDataPoints: 1, gradientColor: ColorGradient.greenRed, touchLocation: CGFloat())
                BarChartCell(value: 1, width: 50, numberOfDataPoints: 1, gradientColor: ColorGradient.whiteBlack, touchLocation: CGFloat())
                BarChartCell(value: 1, width: 50, numberOfDataPoints: 1, gradientColor: ColorGradient(.purple), touchLocation: CGFloat())
            }.environment(\.colorScheme, .dark)
        }
    }
}
