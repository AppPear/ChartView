//
//  Legend.swift
//  LineChart
//
//  Created by András Samu on 2019. 09. 02..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct Legend: View {
    @ObservedObject var data: ChartData
    @Binding var frame: CGRect
    @Binding var hideHorizontalLines: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var stepWidth: CGFloat {
        return frame.size.width / CGFloat(data.points.count-1)
    }
    var stepHeight: CGFloat {
        return frame.size.height / CGFloat(data.points.max()! + data.points.min()!)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ForEach((0...4), id: \.self) { height in
                HStack(alignment: .center){
                    Text("\(self.getYLegend()![height])").offset(x: 0, y: (self.frame.height-CGFloat(self.getYLegend()![height])*self.stepHeight)-(self.frame.height/2))
                        .foregroundColor(Colors.LegendText)
                        .font(.caption)
                     self.line(atHeight: CGFloat(self.getYLegend()![height]), width: self.frame.width)
                        .stroke(colorScheme == .dark ? Colors.LegendDarkColor : Colors.LegendColor, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5,height == 0 ? 0 : 10]))
                        .opacity((self.hideHorizontalLines && height != 0) ? 0 : 1)
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeOut(duration: 0.2))
                        .clipped()
                }
               
            }
            
        }
    }
    
    func line(atHeight: CGFloat, width: CGFloat) -> Path {
        var hLine = Path()
        hLine.move(to: CGPoint(x:5, y: atHeight*stepHeight))
        hLine.addLine(to: CGPoint(x: width, y: atHeight*stepHeight))
        return hLine
    }
    
    func getYLegend() -> [Int]? {
        guard let max = data.points.max() else { return nil }
        guard let min = data.points.min() else { return nil }
        if(min > 0){
            let upperBound = ((max/10)+1) * 10
            let step = upperBound/4
            return [step * 0,step * 1, step * 2, step * 3, step * 4]
        }
        
        return nil
    }
}

struct Legend_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            Legend(data: TestData.data, frame: .constant(geometry.frame(in: .local)), hideHorizontalLines: .constant(false))
        }.frame(width: 320, height: 200)
    }
}
