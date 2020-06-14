//
//  PieChartRow.swift
//  SwiftUICharts
//
//  Created by Nicolas Savoini on 2020-05-24.
//

import SwiftUI

public struct PieChartRow: View {
    @ObservedObject var chartData: ChartData

    var style: ChartStyle

    var slices: [PieSlice] {
        var tempSlices: [PieSlice] = []
        var lastEndDeg: Double = 0
        let maxValue: Double = chartData.data.reduce(0, +)
        
        for slice in chartData.data {
            let normalized: Double = Double(slice) / (maxValue == 0 ? 1 : maxValue)
            let startDeg = lastEndDeg
            let endDeg = lastEndDeg + (normalized * 360)
            lastEndDeg = endDeg
            tempSlices.append(PieSlice(startDeg: startDeg, endDeg: endDeg, value: slice))
        }
        
        return tempSlices
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<self.slices.count) { index in
                    PieChartCell(
                            rect: geometry.frame(in: .local),
                            startDeg: self.slices[index].startDeg,
                            endDeg: self.slices[index].endDeg,
                            index: index,
                            backgroundColor: self.style.backgroundColor.startColor,
                            accentColor: self.style.foregroundColor.rotate(for: index)
                        )
                }
                
            }
        }
    }

}

struct PieChartRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            //Empty Array - Default Colors.OrangeStart
            PieChartRow(
                chartData: ChartData([8, 23, 32, 7, 23, 43]),
                style: defaultMultiColorChartStyle)
            .frame(width: 100, height: 100)
            
            PieChartRow(
                chartData:  ChartData([8, 23, 32, 7, 23, 43]),
                style: multiColorChartStyle)
            .frame(width: 100, height: 100)
            
            PieChartRow(
                chartData:  ChartData([8, 23, 32, 7, 23, 43]),
                style: multiColorChartStyle)
            .frame(width: 100, height: 100)
            
        }.previewLayout(.fixed(width: 125, height: 125))
        
    }
}

private let defaultMultiColorChartStyle = ChartStyle(
    backgroundColor: Color.white,
    foregroundColor: [ColorGradient]())

private let multiColorChartStyle = ChartStyle(
backgroundColor: Color.purple,
foregroundColor: [ColorGradient.greenRed, ColorGradient.whiteBlack])
