import SwiftUI

public struct BarChartRow: View {
    @State var data: [Double] = []
    @State var touchLocation: CGFloat = -1.0

    enum Constant {
        static let spacing: CGFloat = 16.0
    }

    var gradientColor: ColorGradient
    var maxValue: Double {
        data.max() ?? 0
    }

    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom,
                   spacing: (geometry.frame(in: .local).width - Constant.spacing) / CGFloat(self.data.count * 3)) {
                ForEach(0..<self.data.count, id: \.self) { i in
                    BarChartCell(value: self.normalizedValue(index: i),
                                 index: i,
                                 width: Float(geometry.frame(in: .local).width - Constant.spacing),
                                 numberOfDataPoints: self.data.count,
                                 gradientColor: self.gradientColor,
                                 touchLocation: self.$touchLocation)
                        .scaleEffect(self.getScaleSize(touchLocation: self.touchLocation, index: i), anchor: .bottom)
                        .animation(.spring())
                    
                }
            }
            .padding([.top, .leading, .trailing], 10)
            .gesture(DragGesture()
                .onChanged({ value in
                    self.touchLocation = value.location.x/geometry.frame(in: .local).width
                })
                .onEnded({ value in
                    self.touchLocation = -1
                })
            )
        }
    }
    
    func normalizedValue(index: Int) -> Double {
        return Double(data[index])/Double(maxValue)
    }

    func getScaleSize(touchLocation: CGFloat, index: Int) -> CGSize {
        if touchLocation > CGFloat(index)/CGFloat(self.data.count) &&
           touchLocation < CGFloat(index+1)/CGFloat(self.data.count) {
            return CGSize(width: 1.4, height: 1.1)
        }
        return CGSize(width: 1, height: 1)
    }
}

struct BarChartRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                BarChartRow(data:[1,2,3], gradientColor: ColorGradient.greenRed)
                BarChartRow(data:[1,2,3], gradientColor: ColorGradient.whiteBlack)
            }
            Group {
                BarChartRow(data:[1,2,3], gradientColor: ColorGradient.greenRed)
                BarChartRow(data:[1,2,3], gradientColor: ColorGradient.whiteBlack)
            }.environment(\.colorScheme, .dark)
        }
    }
}
