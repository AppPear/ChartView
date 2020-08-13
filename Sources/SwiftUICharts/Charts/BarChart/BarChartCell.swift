import SwiftUI

public struct BarChartCell: View {
    var value: Double
    var index: Int = 0
    var width: Float
    var height: Float
    var numberOfDataPoints: Int
    var gradientColor: ColorGradient
    var touchLocation: CGFloat

    var cellWidth: Double {
        return Double(width)/(Double(numberOfDataPoints) * 1.5)
    }

    @State var firstDisplay: Bool = true

    public init( value: Double,
                 index: Int = 0,
                 width: Float,
                 height: Float,
                 numberOfDataPoints: Int,
                 gradientColor: ColorGradient,
                 touchLocation: CGFloat) {
        self.value = value
        self.index = index
        self.width = width
        self.height = height
        self.numberOfDataPoints = numberOfDataPoints
        self.gradientColor = gradientColor
        self.touchLocation = touchLocation
    }

    public var body: some View {
        ZStack {
            Rectangle()
                .fill(gradientColor.linearGradient(from: .bottom, to: .top))
        }
        .cornerRadius(CGFloat(self.cellWidth / 3.5), corners: [.topLeft, .topRight])
        .position(x: CGFloat(self.cellWidth) / 2.0, y: CGFloat(self.height * Float(value)) * (firstDisplay ? 1.5 : 0.5))
        .frame(width: CGFloat(self.cellWidth), height: CGFloat(self.height * Float(value)))
        .onAppear {
            self.firstDisplay = false
        }
        .onDisappear {
            self.firstDisplay = true
        }
        .transition(.slide)
        .animation(Animation.spring().delay(self.touchLocation < 0 || !firstDisplay ? Double(self.index) * 0.04 : 0))
    }
}

struct BarChartCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                BarChartCell(value: 0, width: 50, height: 300, numberOfDataPoints: 1, gradientColor: ColorGradient.greenRed, touchLocation: CGFloat())

                BarChartCell(value: 1, width: 50, height: 300, numberOfDataPoints: 1, gradientColor: ColorGradient.greenRed, touchLocation: CGFloat())
                BarChartCell(value: 1, width: 50, height: 300, numberOfDataPoints: 1, gradientColor: ColorGradient.whiteBlack, touchLocation: CGFloat())
                BarChartCell(value: 1, width: 50, height: 300, numberOfDataPoints: 1, gradientColor: ColorGradient(.purple), touchLocation: CGFloat())
            }

            Group {
                BarChartCell(value: 1, width: 50, height: 300, numberOfDataPoints: 1, gradientColor: ColorGradient.greenRed, touchLocation: CGFloat())
                BarChartCell(value: 1, width: 50, height: 300, numberOfDataPoints: 1, gradientColor: ColorGradient.whiteBlack, touchLocation: CGFloat())
                BarChartCell(value: 1, width: 50, height: 300, numberOfDataPoints: 1, gradientColor: ColorGradient(.purple), touchLocation: CGFloat())
            }.environment(\.colorScheme, .dark)
        }
    }
}
