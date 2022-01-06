import SwiftUI

/// A type of chart that displays vertical bars for each data point
public struct AdvancedBarChart<Root: ChartDataPoint, ChartValueType: ChartValue>: View, AdvancedChartBase where Root == ChartValueType.Root  {

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

public struct BarChart: View, ChartBase  {
    public var chartData = ChartData<SimpleChartDataPoint>()
    
    public typealias Root = SimpleChartDataPoint
    
    public typealias ChartValueType = SimpleChartValue

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
