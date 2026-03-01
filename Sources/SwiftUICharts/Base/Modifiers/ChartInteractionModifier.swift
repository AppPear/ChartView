import SwiftUI

private struct ChartInteractionModifier: ViewModifier {
    let value: ChartValue?

    func body(content: Content) -> some View {
        content.environment(\.chartInteractionValue, value)
    }
}

private struct ChartSelectionHandlerModifier: ViewModifier {
    let handler: ChartSelectionHandler?

    func body(content: Content) -> some View {
        content.environment(\.chartSelectionHandler, handler)
    }
}

public extension View {
    func chartInteractionValue(_ value: ChartValue?) -> some View {
        modifier(ChartInteractionModifier(value: value))
    }

    func chartSelectionHandler(_ handler: @escaping ChartSelectionHandler) -> some View {
        modifier(ChartSelectionHandlerModifier(handler: handler))
    }
}
