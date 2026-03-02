import SwiftUI

/// Representation of a single data point in a chart that is being observed.
public final class ChartValue: ObservableObject {
    @Published public var currentValue: Double = 0
    @Published public var interactionInProgress: Bool = false

    public init() {
        // no-op
    }
}
