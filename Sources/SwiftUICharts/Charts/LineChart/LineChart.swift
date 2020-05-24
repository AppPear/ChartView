import SwiftUI

public struct LineChart: ChartType {
    public func makeChart(configuration: Self.Configuration, style: Self.Style) -> some View {
        Line(data: configuration.data, style: style)
    }

    public init() {}
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                LineChart().makeChart(
                    configuration: .init(data: [1, 2, 3, 5, 1]),
                    style: .init(backgroundColor: .white, foregroundColor: ColorGradient(.black)))
            }.environment(\.colorScheme, .light)
        
            Group {
                LineChart().makeChart(
                configuration: .init(data: [1, 2, 3]),
                style: .init(backgroundColor: .white, foregroundColor: ColorGradient.redBlack))
            }.environment(\.colorScheme, .dark)
        
        }
        
    }
}
