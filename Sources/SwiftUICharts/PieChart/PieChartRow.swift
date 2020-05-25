//
//  PieChartRow.swift
//  SwiftUICharts
//
//  Created by Nicolas Savoini on 2020-05-24.
//

import SwiftUI

public struct PieChartRow: View {
    var data: [Double]
    
    var style: ChartStyle

    var slices: [PieSlice] {
        var tempSlices: [PieSlice] = []
        var lastEndDeg: Double = 0
        let maxValue = data.reduce(0, +)
        
        for slice in data {
            let normalized: Double = Double(slice)/Double(maxValue)
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
                            accentColor: self.style.foregroundColor.first!
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
                data: [8, 23, 32, 7, 23, 43],
                style: defaultMultiColorChartStyle)
                .frame(width: 100, height: 100)
        }.previewLayout(.fixed(width: 125, height: 125))
        
    }
}

private let defaultMultiColorChartStyle = ChartStyle(
    backgroundColor: Color.white,
    foregroundColor: [ColorGradient]())
