import SwiftUI

/// Representation of a single data point in a chart that is being observed
public class ChartValue: ObservableObject {
    @Published var currentValue: Double = 0
    @Published var interactionInProgress: Bool = false
}
