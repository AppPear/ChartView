import SwiftUI

/// Representation of a single data point in a chart that is being observed
public class SimpleChartValue: ChartValue {
    @Published var currentValue: Double = 0
    @Published var interactionInProgress: Bool = false
}

protocol ChartValue: ObservableObject {
    var currentValue: Double { get set }
    var interactionInProgress: Bool { get set }
}
