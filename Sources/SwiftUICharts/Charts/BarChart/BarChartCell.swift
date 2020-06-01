import SwiftUI

public struct BarChartCell: View {
    @Binding var values: [Double]
    @State var index: Int = 0
    @State var width: Float
    var gradientColor: ColorGradient

    var cellWidth: Double {
        return Double(width)/(Double(values.count) * 1.5)
    }

    @Binding var touchLocation: CGFloat

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(gradientColor.linearGradient(from: .bottom, to: .top))

            }
            .frame(width: CGFloat(self.cellWidth))
        .scaleEffect(CGSize(width: 1, height: self.values[index] / Double(self.values.max() ?? 1)), anchor: .bottom)

        .animation(Animation.spring().delay(self.touchLocation < 0 ?  Double(self.index) * 0.04 : 0))

    }
    
}

struct BarChartCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BarChartCell(values: .constant([0, 1, 2]), width: 50, gradientColor: ColorGradient.greenRed, touchLocation: .constant(CGFloat()))
            Group {
                BarChartCell(values: .constant([1, 1, 2]), width: 50, gradientColor: ColorGradient.greenRed, touchLocation: .constant(CGFloat()))
                BarChartCell(values: .constant([2, 1, 2]), width: 50, gradientColor: ColorGradient.whiteBlack, touchLocation: .constant(CGFloat()))
                BarChartCell(values: .constant([3, 1, 2]), width: 50, gradientColor: ColorGradient(.purple), touchLocation: .constant(CGFloat()))
            }
            
            Group {
                BarChartCell(values: .constant([1, 1, 2]), width: 50, gradientColor: ColorGradient.greenRed, touchLocation: .constant(CGFloat()))
                BarChartCell(values: .constant([2, 1, 2]), width: 50, gradientColor: ColorGradient.whiteBlack, touchLocation: .constant(CGFloat()))
                BarChartCell(values: .constant([3, 1, 2]), width: 50, gradientColor: ColorGradient(.purple), touchLocation: .constant(CGFloat()))
            }.environment(\.colorScheme, .dark)
        }
        
    }
}
