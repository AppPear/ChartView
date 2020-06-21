import SwiftUI

public struct BarChart: ChartType {
    public func makeChart(data: Self.Data, style: Self.Style) -> some View {
        BarChartRow(chartData: data, style: style)
    }
    public init() {}
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BarChart().makeChart(
            data: .init([0]),
            style: .init(backgroundColor: .white, foregroundColor: ColorGradient.redBlack))
            Group {
                BarChart().makeChart(
                    data: .init([1, 2, 3, 5, 1]),
                    style: .init(backgroundColor: .white, foregroundColor: ColorGradient.redBlack))
            }.environment(\.colorScheme, .light)
        
            Group {
                BarChart().makeChart(
                data: .init([1, 2, 3]),
                style: .init(backgroundColor: .white, foregroundColor: ColorGradient.redBlack))
            }.environment(\.colorScheme, .dark)
        
        }
    }
}
