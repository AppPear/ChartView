import SwiftUI

private struct ChartLineWidthModifier: ViewModifier {
    @Environment(\.chartLineConfig) private var currentConfig

    let width: CGFloat

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.lineWidth = width
        return content.environment(\.chartLineConfig, updated)
    }
}

private struct ChartLineBackgroundModifier: ViewModifier {
    @Environment(\.chartLineConfig) private var currentConfig

    let gradient: ColorGradient?

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.backgroundGradient = gradient
        return content.environment(\.chartLineConfig, updated)
    }
}

private struct ChartLineMarksModifier: ViewModifier {
    @Environment(\.chartLineConfig) private var currentConfig

    let visible: Bool
    let color: ColorGradient?

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.showChartMarks = visible
        updated.customChartMarksColors = color
        return content.environment(\.chartLineConfig, updated)
    }
}

private struct ChartLineStyleModifier: ViewModifier {
    @Environment(\.chartLineConfig) private var currentConfig

    let style: LineStyle

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.lineStyle = style
        return content.environment(\.chartLineConfig, updated)
    }
}

private struct ChartLineAnimationModifier: ViewModifier {
    @Environment(\.chartLineConfig) private var currentConfig

    let enabled: Bool

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.animationEnabled = enabled
        return content.environment(\.chartLineConfig, updated)
    }
}

public extension View {
    func chartLineWidth(_ width: CGFloat) -> some View {
        modifier(ChartLineWidthModifier(width: width))
    }

    func chartLineBackground(_ gradient: ColorGradient?) -> some View {
        modifier(ChartLineBackgroundModifier(gradient: gradient))
    }

    func chartLineMarks(_ visible: Bool, color: ColorGradient? = nil) -> some View {
        modifier(ChartLineMarksModifier(visible: visible, color: color))
    }

    func chartLineStyle(_ style: LineStyle) -> some View {
        modifier(ChartLineStyleModifier(style: style))
    }

    func chartLineAnimation(_ enabled: Bool) -> some View {
        modifier(ChartLineAnimationModifier(enabled: enabled))
    }
}
