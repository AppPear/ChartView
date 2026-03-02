import SwiftUI

/// View containing data and chart content.
public struct CardView<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme

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
                    .fill(cardBackgroundColor)
                    .shadow(color: shadowColor, radius: 8, x: 0, y: 2)
            }
            VStack(alignment: .leading) {
                content()
            }
            .clipShape(RoundedRectangle(cornerRadius: showShadow ? 20 : 0))
        }
    }

    private var cardBackgroundColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.08) : Color.white
    }

    private var shadowColor: Color {
        colorScheme == .dark ? Color.black.opacity(0.45) : Color.black.opacity(0.12)
    }
}
