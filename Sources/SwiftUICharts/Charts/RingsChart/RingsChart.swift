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

	// TODO - should put background opacity, ring width & spacing as chart style values
	
	public var body: some View {
		RingsChartRow(width:10.0, spacing:5.0, chartData: data, style: style)
	}

}
