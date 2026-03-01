import SwiftUI

/// View containing data and chart content.
public struct CardView<Content: View>: View {
    let content: () -> Content

    private var showShadow: Bool

    public init(showShadow: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.showShadow = showShadow
        self.content = content
    }

    public var body: some View {
        ZStack {
            if showShadow {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: Color(white: 0.9, opacity: 1), radius: 8)
            }
            VStack(alignment: .leading) {
                content()
            }
            .clipShape(RoundedRectangle(cornerRadius: showShadow ? 20 : 0))
        }
    }
}
