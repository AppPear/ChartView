import SwiftUI

public struct CardView<Content: View>: View, ChartBase {
    public var chartData = ChartData()
    let content: () -> Content

    @EnvironmentObject var style: ChartStyle

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.gray, radius: 8)
            VStack {
                self.content()
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
