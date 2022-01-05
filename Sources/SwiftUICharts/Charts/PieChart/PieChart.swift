import SwiftUI

/// A type of chart that displays a slice of "pie" for each data point
public struct PieChart<Root: ChartDataPoint>: View, ChartBase {

    public var chartData = ChartData<Root>()

    @EnvironmentObject var data: ChartData<Root>
    @EnvironmentObject var style: ChartStyle

	/// The content and behavior of the `PieChart`.
	///
	///
    public var body: some View {
        PieChartRow(chartData: data, style: style)
    }

    public init() {}
}
