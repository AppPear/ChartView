import SwiftUI

struct AnyChartType: ChartType {
    private let chartMaker: (ChartType.Data, ChartType.Style) -> AnyView

    init<S: ChartType>(_ type: S) {
        self.chartMaker = type.makeTypeErasedBody
    }

    func makeChart(data: ChartType.Data, style: ChartType.Style) -> AnyView {
        self.chartMaker(data, style)
    }
}

fileprivate extension ChartType {
    func makeTypeErasedBody(data: ChartType.Data, style: ChartType.Style) -> AnyView {
        AnyView(makeChart(data: data, style: style))
    }
}
