import SwiftUI

/// Representation of a single data point in a chart that is being observed
public class SimpleChartValue: ChartValue {
    @Published public var currentValue: SimpleChartDataPoint = SimpleChartDataPoint(chartPoint: 0, chartValue: "")
    @Published public var interactionInProgress: Bool = false
}

public protocol ChartValue: ObservableObject {
    associatedtype Root: ChartDataPoint
    var currentValue: Root { get set }
    var interactionInProgress: Bool { get set }
}
