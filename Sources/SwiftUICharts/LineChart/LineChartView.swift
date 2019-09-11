//
//  LineCard.swift
//  LineChart
//
//  Created by András Samu on 2019. 08. 31..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct LineChartView: View {
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    @ObservedObject var data:ChartData
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    @State private var touchLocation:CGPoint = .zero
    @State private var showIndicatorDot: Bool = false
    @State private var currentValue: Int = 2 {
        didSet{
            if (oldValue != self.currentValue && showIndicatorDot) {
                selectionFeedbackGenerator.selectionChanged()
            }
            
        }
    }
    let frame = CGSize(width: 180, height: 120)
    
    public init(data: [Int], title: String, legend: String? = nil, style: ChartStyle = Styles.lineChartStyleOne ){
        self.data = ChartData(points: data)
        self.title = title
        self.legend = legend
        self.style = style
    }
    
    var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: 20).fill(self.style.backgroundColor).frame(width: frame.width, height: 240, alignment: .center).shadow(radius: 8)
            VStack(alignment: .leading){
                if(!self.showIndicatorDot){
                    VStack(alignment: .leading, spacing: 8){
                        Text(self.title).font(.title).bold().foregroundColor(self.style.textColor)
                        if (self.legend != nil){
                            Text(self.legend!).font(.callout).foregroundColor(self.style.legendTextColor)
                        }
                        HStack {
                            Image(systemName: "arrow.up")
                            Text("14%")
                        }
                    }
                    .transition(.opacity)
                    .animation(.easeIn(duration: 0.1))
                    .padding([.leading, .top])
                }else{
                    HStack{
                        Spacer()
                        Text("\(self.currentValue)")
                            .font(.system(size: 41, weight: .bold, design: .default))
                            .offset(x: 0, y: 30)
                        Spacer()
                    }
                    .transition(.scale)
                    .animation(.spring())
                    
                }
                Spacer()
                GeometryReader{ geometry in
                    Line(data: self.data, frame: .constant(geometry.frame(in: .local)), touchLocation: self.$touchLocation, showIndicator: self.$showIndicatorDot)
                }
                .frame(width: frame.width, height: frame.height)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(x: 0, y: 0)
            }.frame(width: self.style.chartFormSize.width, height: self.style.chartFormSize.height)
        }
        .gesture(DragGesture()
        .onChanged({ value in
            self.touchLocation = value.location
            self.showIndicatorDot = true
            self.getClosestDataPoint(toPoint: value.location, width:self.frame.width, height: self.frame.height)
        })
            .onEnded({ value in
                self.showIndicatorDot = false
            })
        )
    }
    
    func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let stepWidth: CGFloat = width / CGFloat(data.points.count-1)
        let stepHeight: CGFloat = height / CGFloat(data.points.max()! + data.points.min()!)
        
        let index:Int = Int(round((toPoint.x)/stepWidth))
        if (index >= 0 && index < data.points.count){
            self.currentValue = self.data.points[index]
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(self.data.points[index])*stepHeight)
        }
        return .zero
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Basic")
                .environment(\.colorScheme, .light)
        }
    }
}
