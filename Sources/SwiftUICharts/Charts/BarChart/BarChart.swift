import SwiftUI

/// A type of chart that displays vertical bars for each data point
public struct BarChart: View, ChartBase {
    public var chartData = ChartData()

    @EnvironmentObject var data: ChartData
    @EnvironmentObject var style: ChartStyle

	/// The content and behavior of the `BarChart`.
	///
	///
    public var body: some View {
        BarChartRow(chartData: data, style: style)
    }

    public init() {}
}
