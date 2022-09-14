import SwiftUI

/// Protocol for any type of chart, to get access to underlying data
public protocol ChartBase: View {
    var chartData: ChartData { get }
}
