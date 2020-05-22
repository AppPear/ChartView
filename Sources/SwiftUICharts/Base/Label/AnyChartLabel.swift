import SwiftUI

struct AnyChartLabel: ChartLabel {
    private let labelMaker: (ChartLabel.Configuration) -> AnyView

    init<S: ChartLabel>(_ label: S) {
        self.labelMaker = label.makeTypeErasedBody
    }

    func makeLabel(configuration: ChartLabel.Configuration) -> AnyView {
        self.labelMaker(configuration)
    }
}

fileprivate extension ChartLabel {
    func makeTypeErasedBody(configuration: ChartLabel.Configuration) -> AnyView {
        AnyView(makeLabel(configuration: configuration))
    }
}
