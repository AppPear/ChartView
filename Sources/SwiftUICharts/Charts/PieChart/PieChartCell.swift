//
//  PieChartCell.swift
//  SwiftUICharts
//
//  Created by Nicolas Savoini on 2020-05-24.
//

import SwiftUI

struct PieSlice: Identifiable {
    var id = UUID()
    var startDeg: Double
    var endDeg: Double
    var value: Double
    //var normalizedValue: Double
}

public struct PieChartCell: View {
    @State private var show: Bool = false
    var rect: CGRect
    var radius: CGFloat {
        return min(rect.width, rect.height)/2
    }
    var startDeg: Double
    var endDeg: Double
    var path: Path {
        var path = Path()
        path.addArc(
            center: rect.mid,
            radius: self.radius,
            startAngle: Angle(degrees: self.startDeg),
            endAngle: Angle(degrees: self.endDeg),
            clockwise: false)
        path.addLine(to: rect.mid)
        path.closeSubpath()
        return path
    }
    var index: Int
    
    // Section line border color
    var backgroundColor: Color
    
    // Section color
    var accentColor: ColorGradient
    
    public var body: some View {
        Group {
            path
                .fill(self.accentColor.linearGradient(from: .bottom, to: .top))
                .overlay(path.stroke(self.backgroundColor, lineWidth: 2))
                .scaleEffect(self.show ? 1 : 0)
                .animation(Animation.spring().delay(Double(self.index) * 0.04))
                .onAppear {
                    self.show = true
            }
            
        }
    }
}

struct PieChartCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            GeometryReader { geometry in
                PieChartCell(
                    rect: geometry.frame(in: .local),
                    startDeg: 00.0,
                    endDeg: 90.0,
                    index: 0,
                    backgroundColor: Color.red,
                    accentColor: ColorGradient.greenRed)
                }.frame(width: 100, height: 100)
            
            GeometryReader { geometry in
            PieChartCell(
                rect: geometry.frame(in: .local),
                startDeg: 0.0,
                endDeg: 90.0,
                index: 0,
                backgroundColor: Color.green,
                accentColor: ColorGradient.redBlack)
            }.frame(width: 100, height: 100)
            
            GeometryReader { geometry in
            PieChartCell(
                rect: geometry.frame(in: .local),
                startDeg: 100.0,
                endDeg: 135.0,
                index: 0,
                backgroundColor: Color.black,
                accentColor: ColorGradient.whiteBlack)
            }.frame(width: 100, height: 100)
            
            GeometryReader { geometry in
            PieChartCell(
                rect: geometry.frame(in: .local),
                startDeg: 185.0,
                endDeg: 290.0,
                index: 0,
                backgroundColor: Color.purple,
                accentColor: ColorGradient(.purple))
            }.frame(width: 100, height: 100)
            
        }.previewLayout(.fixed(width: 125, height: 125))
    }
}
