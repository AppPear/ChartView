//  ChartView.swift
//  Created by Samu András on 2020. 05. 22..

import SwiftUI

public struct ChartView: View {
    @Environment(\.chartType) private var chartType
    @Environment(\.chartStyle) private var chartStyle
    @Environment(\.title) private var title

    private var configuration: ChartTypeConfiguration

    public var body: some View {
        self.chartType.makeChart(configuration: configuration, style: chartStyle)
    }
}

extension ChartView {
    public init(data: [Double]) {
        self.configuration = ChartTypeConfiguration(data: data)
    }
}
