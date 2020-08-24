import SwiftUI

/// A type of chart that displays a line connecting the data points
public struct LineChart: View, ChartBase {
    public var chartData = ChartData()

    @EnvironmentObject var data: ChartData
    @EnvironmentObject var style: ChartStyle

	/// The content and behavior of the `LineChart`.
	///
	///
    public var body: some View {
        Line(chartData: data, style: style)
    }
    
    public init() {}
}
