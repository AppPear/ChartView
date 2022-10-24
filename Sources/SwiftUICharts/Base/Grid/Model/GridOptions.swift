import SwiftUI

public final class GridOptions: ObservableObject {
    @Published public var numberOfHorizontalLines: Int = 3
    @Published public var numberOfVerticalLines: Int = 3
    @Published public var strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 1, lineCap: .round, dash: [5, 10])
    @Published public var color: Color = Color(white: 0.85)
    @Published public var showBaseLine: Bool = true
    @Published public var baseStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5, 0])

    public init() {
        // no-op
    }
}
