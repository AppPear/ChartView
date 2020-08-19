import SwiftUI

/// A single vertical bar in a `BarChart`
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

    @State private var firstDisplay: Bool = true

	/// Initialize
	/// - Parameters:
	///   - value: <#value description#>
	///   - index: <#index description#>
	///   - width: <#width description#>
	///   - numberOfDataPoints: <#numberOfDataPoints description#>
	///   - gradientColor: <#gradientColor description#>
	///   - touchLocation: <#touchLocation description#>
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
        .scaleEffect(CGSize(width: 1, height: self.firstDisplay ? 0.0 : self.value), anchor: .bottom)
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
