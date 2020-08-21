//
//  RingsChart.swift
//  ChartViewV2Demo
//
//  Created by Dan Wood on 8/20/20.
//

import SwiftUI

public struct RingsChart: View, ChartBase {
	public var chartData = ChartData()

	@EnvironmentObject var data: ChartData
	@EnvironmentObject var style: ChartStyle

	public var body: some View {
		RingsChartRow(chartData: data, style: style)
	}

}


struct RingsChart_Previews: PreviewProvider {
    static var previews: some View {
        RingsChart()
    }
}
