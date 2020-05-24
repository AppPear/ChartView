import SwiftUI

public struct BarChartCell : View {
    @State var value: Double
    @State var index: Int = 0
    @State var width: Float
    @State var numberOfDataPoints: Int
    var gradientColor: ColorGradient

    var cellWidth: Double {
        return Double(width)/(Double(numberOfDataPoints) * 1.5)
    }

    @State var scaleValue: Double = 0
    @Binding var touchLocation: CGFloat
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(gradient: gradientColor.gradient, startPoint: .bottom, endPoint: .top))
            }
            .frame(width: CGFloat(self.cellWidth))
            .scaleEffect(CGSize(width: 1, height: self.scaleValue), anchor: .bottom)
            .onAppear(){
                self.scaleValue = self.value
            }
        .animation(Animation.spring().delay(self.touchLocation < 0 ?  Double(self.index) * 0.04 : 0))
    }
}
