import SwiftUI

public class LineChartProperties: ObservableObject {
    @Published var lineWidth: CGFloat = 2.0
    @Published var showBackground: Bool = false
    @Published var showChartMarks: Bool = true
    @Published var lineStyle: LineStyle = .curved

    public init() {
        // no-op
    }
}
