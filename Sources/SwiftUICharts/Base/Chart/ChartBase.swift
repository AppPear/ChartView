import SwiftUI

/// Protocol for any type of chart, to get access to underlying data
public protocol ChartBase {
    associatedtype Root: ChartDataPoint
    var chartData: ChartData<Root> { get }
}
