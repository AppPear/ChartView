import SwiftUI

public struct BarChartRow: View {
    
    @Binding var data: [Double]
    @State var touchLocation: CGFloat = -1.0

    enum Constant {
        static let spacing: CGFloat = 16.0
    }

    var style: ChartStyle

    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom,
                   spacing: (geometry.frame(in: .local).width - Constant.spacing) / CGFloat(self.data.count * 3)) {
                    HStack {
                        ForEach(0..<self.data.count, id: \.self) { index in
                            BarChartCell(values: self.$data,
                                     index: index,
                                     width: Float(geometry.frame(in: .local).width - Constant.spacing),
                                     gradientColor: self.style.foregroundColor.rotate(for: index),
                                     touchLocation: self.$touchLocation)
                            .scaleEffect(self.getScaleSize(touchLocation: self.touchLocation, index: index), anchor: .bottom)
                            .animation(.spring())
                        
                        }
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
            BarChartRow(data: .constant([0, 1, 2]), style: styleGreenRed)
            Group {
                BarChartRow(data: .constant([0, 1, 2]), style: styleGreenRed)
                BarChartRow(data: .constant([2, 0.2, 1]), style: styleGreenRedWhiteBlack)
            }
            Group {
                BarChartRow(data: .constant([0.2, 1, 2]), style: styleGreenRed)
                BarChartRow(data: .constant([2, 0.3, 2]), style: styleGreenRedWhiteBlack)
            }.environment(\.colorScheme, .dark)
        }
    }
}

private let styleGreenRed = ChartStyle(backgroundColor: .white, foregroundColor: .greenRed)

private let styleGreenRedWhiteBlack = ChartStyle(
    backgroundColor: ColorGradient.init(.white),
    foregroundColor: [ColorGradient.redBlack, ColorGradient.whiteBlack])

