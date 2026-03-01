import SwiftUI

private struct ChartGridLinesModifier: ViewModifier {
    @Environment(\.chartGridConfig) private var currentConfig

    let horizontal: Int
    let vertical: Int

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.numberOfHorizontalLines = horizontal
        updated.numberOfVerticalLines = vertical
        return content.environment(\.chartGridConfig, updated)
    }
}

private struct ChartGridStrokeModifier: ViewModifier {
    @Environment(\.chartGridConfig) private var currentConfig

    let style: StrokeStyle
    let color: Color

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.strokeStyle = style
        updated.color = color
        return content.environment(\.chartGridConfig, updated)
    }
}

private struct ChartGridBaselineModifier: ViewModifier {
    @Environment(\.chartGridConfig) private var currentConfig

    let visible: Bool
    let style: StrokeStyle?

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.showBaseLine = visible
        if let style = style {
            updated.baseStrokeStyle = style
        }
        return content.environment(\.chartGridConfig, updated)
    }
}

public extension View {
    func chartGridLines(horizontal: Int, vertical: Int) -> some View {
        modifier(ChartGridLinesModifier(horizontal: horizontal, vertical: vertical))
    }

    func chartGridStroke(style: StrokeStyle, color: Color) -> some View {
        modifier(ChartGridStrokeModifier(style: style, color: color))
    }

    func chartGridBaseline(_ visible: Bool, style: StrokeStyle? = nil) -> some View {
        modifier(ChartGridBaselineModifier(visible: visible, style: style))
    }
}
