import SwiftUI

public struct BarChart: ChartType {
    public func makeChart(configuration: Self.Configuration, style: Self.Style) -> some View {
        BarChartRow(data: configuration.data, gradientColor: style.foregroundColor)
    }

    public init() {}
}
