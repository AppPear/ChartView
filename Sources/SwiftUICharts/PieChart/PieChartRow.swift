//
//  PieChartRow.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartRow : View {
    var data: [Double]
    
    //Line color
    var backgroundColor: Color
    
    // Slice fill color
    var accentColors: [Color]
    
    var slices: [PieSlice] {
        var tempSlices:[PieSlice] = []
        var lastEndDeg:Double = 0
        let maxValue = data.reduce(0, +)
        
        for slice in data {
            let normalized:Double = Double(slice)/Double(maxValue)
            let startDeg = lastEndDeg
            let endDeg = lastEndDeg + (normalized * 360)
            lastEndDeg = endDeg
            tempSlices.append(PieSlice(startDeg: startDeg, endDeg: endDeg, value: slice, normalizedValue: normalized))
        }
        
        return tempSlices
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(0..<self.slices.count){ i in
                    PieChartCell(
                        rect: geometry.frame(in: .local),
                        startDeg: self.slices[i].startDeg,
                        endDeg: self.slices[i].endDeg,
                        index: i,
                        backgroundColor: self.backgroundColor,
                        accentColor: self.chooseColor(colors: self.accentColors, index: i)
                    )
                }
            }
        }
    }
    
    private func chooseColor(colors: [Color], index: Int) -> Color {
        if colors.isEmpty {
            return Colors.OrangeStart
        }

        if colors.count <= index {
            return colors[index % colors.count]
        }
    
        return colors[index]
    }
}

#if DEBUG
struct PieChartRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            //Empty Array - Default Colors.OrangeStart
            PieChartRow(
                data:[8,23,54,32,12,37,7,23,43],
                backgroundColor: Color.blue,
                accentColors: [Color]())
                .frame(width: 100, height: 100)
            
            //Array - 1 Color
            PieChartRow(
                data:[5,10,15,3,9,35],
                backgroundColor: Color.white,
                accentColors: [Color.black])
                .frame(width: 100, height: 100)
            
            //Array - Less Color than slice
            PieChartRow(
            data:[3,25,25,47],
            backgroundColor: Color.red,
            accentColors: [Color.yellow, Color.orange])
            .frame(width: 100, height: 100)
            
            //Array - Color = Slice
            PieChartRow(
            data:[3,25,25,47],
            backgroundColor: Color.black,
            accentColors: [Color.blue, Color.green, Color.yellow, Color.purple])
            .frame(width: 100, height: 100)
            
            //Array - More Color than slice
            PieChartRow(
            data:[3,25],
            backgroundColor: Color.white,
            accentColors: [Color.blue, Color.green, Color.yellow, Color.purple])
            .frame(width: 100, height: 100)
            
        }.previewLayout(.fixed(width: 125, height: 125))
        
    }
}
#endif
