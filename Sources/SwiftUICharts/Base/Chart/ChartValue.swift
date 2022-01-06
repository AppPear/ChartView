import SwiftUI

/// Representation of a single data point in a chart that is being observed
public class SimpleChartValue: ChartValue {
    @Published public var currentValue: SimpleChartDataPoint? = nil
    @Published public var interactionInProgress: Bool = false
}

/// The object that is used to report the currently selected ChartDataPoint and if the user is interacting with the chart
public protocol ChartValue: ObservableObject {
    associatedtype Root: ChartDataPoint
    /// The current or last known value the user interacted with.  This value should be @Published for proper reporting
    var currentValue: Root? { get set }
    /// If the user is currently interacting, this value is true.  This value should be @Published for proper reporting
    var interactionInProgress: Bool { get set }
}
