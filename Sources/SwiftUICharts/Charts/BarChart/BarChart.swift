import SwiftUI

/// A type of chart that displays vertical bars for each data point
public struct BarChart<Root: ChartDataPoint, ChartValueType: ChartValue>: View, ChartBase where Root == ChartValueType.Root  {
    public var chartData = ChartData<Root>()

    @EnvironmentObject var data: ChartData<Root>
    @EnvironmentObject var style: ChartStyle

	/// The content and behavior of the `BarChart`.
	///
	///
    public var body: some View {
        BarChartRow<Root, ChartValueType>(chartData: data, style: style)
    }

    public init() {}
}
