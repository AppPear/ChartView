import SwiftUI

public class LineChartProperties: ObservableObject {
    @Published var lineWidth: CGFloat = 2.0
    @Published var backgroundGradient: ColorGradient?
    @Published var showChartMarks: Bool = false
    @Published var customChartMarksColors: ColorGradient?
    @Published var lineStyle: LineStyle = .curved
    @Published var animationEnabled: Bool = true
    public init() {
        // no-op
    }
}
