import SwiftUI

/// A type of chart that displays a slice of "pie" for each data point
public struct PieChart: ChartBase {
    public var chartData = ChartData()

    @EnvironmentObject var style: ChartStyle

	/// The content and behavior of the `PieChart`.
	///
	///
    public var body: some View {
        PieChartRow(chartData: chartData, style: style)
    }

    public init() {}
}
