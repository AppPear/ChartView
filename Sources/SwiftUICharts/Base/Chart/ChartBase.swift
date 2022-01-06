import SwiftUI

/// Protocol for any type of chart, to get access to underlying data
public protocol ChartBase {
    associatedtype Root
    associatedtype ChartValueType: ChartValue where ChartValueType.Root == Root
    var chartData: ChartData<Root> { get set }
}
