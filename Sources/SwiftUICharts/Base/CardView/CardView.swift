import SwiftUI

public struct CardView<Content: View>: View {
    @Environment(\.chartStyle) private var chartStyle
    
    let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(self.chartStyle.backgroundColor.linearGradient(from: .bottom, to: .top))
                .cornerRadius(20)
                .shadow(color: Color.gray, radius: 8)
            VStack {
                self.content().padding(.bottom)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            Group {
                VStack {
                    HStack {
                        ChartLabel("Title", type: .title, size: .large)
                        Spacer()
                        ChartView(data: .constant(ChartTypeConfiguration(data: [1, 2, 3])))
                    }
                }.style(ChartStyle.init(backgroundColor: .white, foregroundColor: ColorGradient.greenRed))
                    .frame(width: 240, height: 360)
                    .padding()
            }
            
            Group {
                CardView {
                    ChartLabel("Title", type: .title, size: .large)
                    ChartView(data: .constant(ChartTypeConfiguration(data: [1, 2, 3])))
                }.style(ChartStyle.init(backgroundColor: .white, foregroundColor: ColorGradient.greenRed))
                    .frame(width: 240, height: 360)
                    .padding()
            }.environment(\.colorScheme, .dark)
        }
    }
}

