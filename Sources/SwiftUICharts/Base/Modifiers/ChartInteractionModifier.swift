import SwiftUI

private struct ChartInteractionModifier: ViewModifier {
    let value: ChartValue?

    func body(content: Content) -> some View {
        content.environment(\.chartInteractionValue, value)
    }
}

public extension View {
    func chartInteractionValue(_ value: ChartValue?) -> some View {
        modifier(ChartInteractionModifier(value: value))
    }
}
