import SwiftUI

public struct RingsChart: ChartBase {
	public var chartData = ChartData()

	@EnvironmentObject var style: ChartStyle

	// TODO - should put background opacity, ring width & spacing as chart style values
	
	public var body: some View {
		RingsChartRow(width:10.0, spacing:5.0, chartData: chartData, style: style)
	}

    public init() {}
}
