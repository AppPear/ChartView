import SwiftUI

public struct BarChart: ChartType {
    public func makeChart(configuration: Self.Configuration, style: Self.Style) -> some View {
        BarChartRow(data: configuration.data, gradientColor: style.foregroundColor)
    }
    public init() {}
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                BarChart().makeChart(
                    configuration: .init(data: [1,2,3,5,1]),
                    style: .init(backgroundColor: .white, foregroundColor: ColorGradient.redBlack))
            }.environment(\.colorScheme, .light)
        
            Group {
                BarChart().makeChart(
                configuration: .init(data: [1,2,3]),
                style: .init(backgroundColor: .white, foregroundColor: ColorGradient.redBlack))
            }.environment(\.colorScheme, .dark)
        
        }
        
    }
}
