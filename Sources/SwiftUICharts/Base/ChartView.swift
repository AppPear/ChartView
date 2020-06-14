//  ChartView.swift
//  Created by Samu András on 2020. 05. 22..

import SwiftUI

public struct ChartView: View {
    @Environment(\.chartType) private var chartType
    @Environment(\.chartStyle) private var chartStyle

    private var data: ChartData

    public init(data: ChartData) {
        self.data = data
    }

    public var body: some View {
        self.chartType.makeChart(data: data, style: chartStyle)
    }
}

extension ChartView {
//    public init(data: [Double]) {
//        self.configuration = ChartTypeConfiguration(data: data)
//    }


}
