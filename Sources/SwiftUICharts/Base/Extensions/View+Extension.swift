import SwiftUI

extension View {
    public func type<S>(_ type: S) -> some View where S : ChartType {
        self.environment(\.chartType, AnyChartType(type))
    }

    public func style(_ style: ChartStyle) -> some View {
        self.environment(\.chartStyle, style)
    }
}
