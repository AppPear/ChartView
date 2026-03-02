import SwiftUI

private struct ChartPerformanceModifier: ViewModifier {
    let mode: ChartPerformanceMode

    func body(content: Content) -> some View {
        content.environment(\.chartPerformanceConfig, ChartPerformanceConfig(mode: mode))
    }
}

public extension View {
    func chartPerformance(_ mode: ChartPerformanceMode) -> some View {
        modifier(ChartPerformanceModifier(mode: mode))
    }
}
