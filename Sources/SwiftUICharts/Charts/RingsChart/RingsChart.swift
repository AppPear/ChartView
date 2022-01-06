//
//  RingsChart.swift
//  ChartViewV2Demo
//
//  Created by Dan Wood on 8/20/20.
//

import SwiftUI

public struct RingsChart<Root: ChartDataPoint, ChartValueType: ChartValue>: View, ChartBase where Root == ChartValueType.Root {
	public var chartData = ChartData<Root>()

	@EnvironmentObject var data: ChartData<Root>
	@EnvironmentObject var style: ChartStyle

	// TODO - should put background opacity, ring width & spacing as chart style values
	
	public var body: some View {
		RingsChartRow<Root, ChartValueType>(width:10.0, spacing:5.0, chartData: data, style: style)
	}

    public init() {}
}
