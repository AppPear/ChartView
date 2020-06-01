//
//  PieChart.swift
//  SwiftUICharts
//
//  Created by Nicolas Savoini on 2020-05-24.
//

import SwiftUI

public struct PieChart: ChartType {
    public func makeChart(configuration: Self.Configuration, style: Self.Style) -> some View {
        PieChartRow(data: configuration.data, style: style)
    }
    public init() {}
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PieChart().makeChart(
                configuration: .constant(ChartTypeConfiguration(data: [0])),
            style: styleOneColor)
            
            Group {
                PieChart().makeChart(
                    configuration: .constant(ChartTypeConfiguration(data: [55, 78, 106, 20, 12])),
                style: styleOneColor)
                PieChart().makeChart(
                    configuration: .constant(ChartTypeConfiguration(data: [0])),
                style: styleTwoColor)
                PieChart().makeChart(
                    configuration: .constant(ChartTypeConfiguration(data: [1, 1, 1, 1, 1, 1])),
                style: trivialPursuit)
            }.environment(\.colorScheme, .light)
            
            Group {
                PieChart().makeChart(
                    configuration: .constant(ChartTypeConfiguration(data: [50, 75, 25, 35,  24, 96])),
                style: styleOneColor)
                PieChart().makeChart(
                    configuration: .constant(ChartTypeConfiguration(data: [50, 75, 25, 35,  24, 96])),
                style: styleTwoColor)
                PieChart().makeChart(
                    configuration: .constant(ChartTypeConfiguration(data: [1, 1, 1, 1, 1, 1, 1])),
                style: trivialPursuit)
            }.environment(\.colorScheme, .dark)
            
        }.previewLayout(.fixed(width: 250, height: 400))
    }
}

private let styleOneColor = ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient.init(.pink))

private let styleTwoColor = ChartStyle(backgroundColor: ColorGradient(.black), foregroundColor: [ColorGradient(.yellow), ColorGradient(.red)])

private let trivialPursuit = ChartStyle(
    backgroundColor: .yellow,
    foregroundColor: [ColorGradient(.yellow),
                      ColorGradient(.pink),
                      ColorGradient(.green),
                      ColorGradient(.primary),
                      ColorGradient(.blue),
                      ColorGradient(.orange)])

