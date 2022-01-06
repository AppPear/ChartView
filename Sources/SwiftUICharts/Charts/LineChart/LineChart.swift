import SwiftUI

/// A type of chart that displays a line connecting the data points
public struct LineChart<Root: ChartDataPoint, ChartValueType: ChartValue>: View, ChartBase where Root == ChartValueType.Root  {
    
    
    public var chartData = ChartData<Root>([], keyPathForGraphValue: \.chartPoint)

    @EnvironmentObject var data: ChartData<Root>
    @EnvironmentObject var style: ChartStyle

	/// The content and behavior of the `LineChart`.
	///
	///
    public var body: some View {
        Line<Root, ChartValueType>(chartData: data, style: style)
    }
    
    public init() {}
}
