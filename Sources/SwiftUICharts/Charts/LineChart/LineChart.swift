import SwiftUI

public struct LineChart: ChartType {
    public func makeChart(configuration: Self.Configuration, style: Self.Style) -> some View {
        Line(data: configuration.data, gradientColor: style.foregroundColor)
    }

    public init() {}
}
