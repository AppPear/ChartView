import SwiftUI

private struct ChartStyleModifier: ViewModifier {
    let style: ChartStyle

    func body(content: Content) -> some View {
        content.environment(\.chartStyle, style)
    }
}

public extension View {
    func chartStyle(_ style: ChartStyle) -> some View {
        modifier(ChartStyleModifier(style: style))
    }
}
