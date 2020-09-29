//
//  LineCard.swift
//  LineChart
//
//  Created by András Samu on 2019. 08. 31..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct LineChartView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var data:ChartData
    public var title: String?
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    var indicatorKnob: Color
    
    private var rawData: [Double]
    public var formSize:CGSize
    public var dropShadow: Bool
    public var valueSpecifier:String
    public var curvedLines: Bool
    public var displayChartStats: Bool
    
    public var width: CGFloat
    public var height: CGFloat
    
    @State private var touchLocation:CGPoint = .zero
    @State private var showIndicatorDot: Bool = false
    @State private var currentValue: Double = 2 {
        didSet{
            if (oldValue != self.currentValue && showIndicatorDot) {
                HapticFeedback.playSelection()
            }
        }
    }
    var frame = CGSize(width: 180, height: 120)
    private var rateValue: Int?
    
    public init(data: [Double],
                title: String? = nil,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                form: CGSize? = ChartForm.extraLarge,
                rateValue: Int? = 14,
                dropShadow: Bool? = false,
                valueSpecifier: String? = "%.1f",
                cursorColor: Color = Colors.IndicatorKnob,
                curvedLines: Bool = true,
                displayChartStats: Bool = true,
                width: CGFloat = 360,
                height: CGFloat = 360) {
        
        self.rawData = data
        self.data = ChartData(points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
        self.formSize = CGSize(width: width, height: height)
        self.width = width
        self.height = height
        frame = CGSize(width: width, height: height/2)
        self.dropShadow = dropShadow!
        self.valueSpecifier = valueSpecifier!
        self.rateValue = rateValue
        self.indicatorKnob = cursorColor
        self.curvedLines = curvedLines
        self.displayChartStats = displayChartStats
    }
    
    private var internalRate: Int? {
        if !self.showIndicatorDot {
            if self.rawData.count > 1 {
                return Int(((self.rawData.last!/self.rawData.first!) - 1)*100)
            } else {
                return nil
            }
        } else {
            if self.rawData.count > 1 {
                return Int(((self.currentValue/self.rawData.first!) - 1)*100)
            } else {
                return nil
            }
        }
    }
    
    public var body: some View {
        ZStack(alignment: .center){
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 8){
                    if (self.title != nil) {
                        Text(self.title!)
                            .font(.title)
                            .bold()
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
                    }
                    if (self.legend != nil){
                        Text(self.legend!)
                            .font(.callout)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor :self.style.legendTextColor)
                    }
                    HStack {
                        if ((self.internalRate ?? 0 != 0) && (self.displayChartStats)) {
                            if (self.internalRate ?? 0 >= 0) {
                                Image(systemName: "arrow.up")
                            } else {
                                Image(systemName: "arrow.down")
                            }
                            if (self.showIndicatorDot) {
                                Text("\(String(format: "%.2f", self.currentValue)) (\(self.internalRate!)%)").font(.callout)
                            } else if (self.rawData.last != nil) {
                                Text("\(String(format: "%.2f", self.rawData.last!)) (\(self.internalRate!)%)").font(.callout)
                            } else {
                                Text("(\(self.internalRate!)%)").font(.callout)
                            }
                        }
                    }
                }
                .transition(.opacity)
                .animation(.easeIn(duration: 0.1))
                .padding([.leading, .top])

                GeometryReader{ geometry in
                    Line(data: self.data,
                         frame: .constant(geometry.frame(in: .local)),
                         touchLocation: self.$touchLocation,
                         showIndicator: self.$showIndicatorDot,
                         minDataValue: .constant(nil),
                         maxDataValue: .constant(nil),
                         lineGradient: self.style.lineGradient,
                         backgroundGradient: self.style.backgroundGradient,
                         indicatorKnob: self.indicatorKnob,
                         curvedLines: self.curvedLines
                    )
                }
                .frame(width: frame.width, height: 2*frame.height + 50)
                .clipShape(RoundedRectangle(cornerRadius: 0))
                .offset(x: 0, y: 0)
            }.frame(width: self.formSize.width).background(Color.white)
        }
        .gesture(DragGesture(minimumDistance: 0)
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
    
    @discardableResult func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(round((toPoint.x)/stepWidth))
        if (index >= 0 && index < points.count){
            self.currentValue = points[index]
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Basic")
                .environment(\.colorScheme, .light)
            
            LineChartView(data: [282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188], title: "Line chart", legend: "Basic")
            .environment(\.colorScheme, .light)
        }
    }
}
