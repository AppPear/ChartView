import SwiftUI

public struct LineChart: ChartType {
    public func makeChart(data: Self.Data, style: Self.Style) -> some View {
        Line(chartData: data, style: style)
    }

    public init() {}
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineChart().makeChart(
            data: .init([0]),
            style: .init(backgroundColor: .white, foregroundColor: ColorGradient(.black)))
            Group {
                LineChart().makeChart(
                    data: .init([1, 2, 3, 5, 1]),
                    style: .init(backgroundColor: .white, foregroundColor: ColorGradient(.black)))
            }.environment(\.colorScheme, .light)
        
            Group {
                LineChart().makeChart(
                data: .init([1, 2, 3]),
                style: .init(backgroundColor: .white, foregroundColor: ColorGradient.redBlack))
            }.environment(\.colorScheme, .dark)
        
        }
        
    }
}
