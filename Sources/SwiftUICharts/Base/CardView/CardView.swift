import SwiftUI

public struct CardView<Content: View>: View {
    @Environment(\.chartStyle) private var chartStyle

    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ZStack{
            Rectangle()
                .fill(self.chartStyle.backgroundColor.linearGradient(from: .bottom, to: .top))
                .cornerRadius(20)
                .shadow(color: Color.gray, radius: 8)
            VStack {
                self.content()
            }
        }
    }
}
