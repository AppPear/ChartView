import SwiftUI

public final class AxisLabelsData: ObservableObject {
    @Published public var axisYLabels: [String] = []
    @Published public var axisXLabels: [String] = []

    public init() {
        // no-op
    }
}
