import SwiftUI

struct AnyChartType: ChartType {
    private let chartMaker: (ChartType.Configuration, ChartType.Style) -> AnyView

    init<S: ChartType>(_ type: S) {
        self.chartMaker = type.makeTypeErasedBody
    }

    func makeChart(configuration: ChartType.Configuration, style: ChartType.Style) -> AnyView {
        self.chartMaker(configuration, style)
    }
}

fileprivate extension ChartType {
    func makeTypeErasedBody(configuration: ChartType.Configuration, style: ChartType.Style) -> AnyView {
        AnyView(makeChart(configuration: configuration, style: style))
    }
}
