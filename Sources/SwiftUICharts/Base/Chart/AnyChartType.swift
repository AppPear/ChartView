import SwiftUI

struct AnyChartType: ChartType {
    private let chartMaker: (ChartType.Configuration) -> AnyView

    init<S: ChartType>(_ type: S) {
        self.chartMaker = type.makeTypeErasedBody
    }

    func makeChart(configuration: ChartType.Configuration) -> AnyView {
        self.chartMaker(configuration)
    }
}

fileprivate extension ChartType {
    func makeTypeErasedBody(configuration: ChartType.Configuration) -> AnyView {
        AnyView(makeChart(configuration: configuration))
    }
}
