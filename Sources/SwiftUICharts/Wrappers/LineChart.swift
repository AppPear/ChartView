//
//  File.swift
//  
//
//  Created by Kalil Fine on 9/27/20.
//

import SwiftUI

public struct LineChart: View {
    public var data: [Double]
    public var title: String?
    public var subTitle: String?
    public var floatingPntNumberFormat: String
    public var cursorColor: Color
    public var curvedLines: Bool
    public var displayChartStats: Bool
    public var minWidth: CGFloat
    public var minHeight: CGFloat
    public var maxWidth: CGFloat
    public var maxHeight: CGFloat
    
    public var titleFont: Font
    public var subtitleFont: Font
    public var priceFont: Font
    public var fullScreen: Bool
    
    private var chartStyle: ChartStyle = Styles.lineChartStyleOne
    private var edgesIgnored: Edge.Set
    
    public init (data: [Double],
                 title: String? = nil,
                 subTitle: String? = nil,
                 style: LineChartStyle? = .primary,
                 curvedLines: Bool = true,
                 cursorColor: Color = Colors.IndicatorKnob,
                 displayChartStats: Bool = false,
                 minWidth: CGFloat = 0,
                 minHeight: CGFloat = 0,
                 maxWidth: CGFloat = .infinity,
                 maxHeight: CGFloat = .infinity,
                 titleFont: Font = .system(size: 30, weight: .regular, design: .rounded),
                 subtitleFont: Font = .system(size: 14, weight: .light, design: .rounded),
                 dataFont: Font = .system(size: 16, weight: .bold, design: .monospaced),
                 floatingPntNumberFormat: String = "%.1f",
                 fullScreen: Bool = false) {
        
        // Assign data
        self.data = data
        self.title = title
        self.subTitle = subTitle
        self.floatingPntNumberFormat = floatingPntNumberFormat
        self.cursorColor = cursorColor
        self.curvedLines = curvedLines
        self.displayChartStats = displayChartStats
        self.minHeight = minHeight
        self.minWidth = minWidth
        self.maxHeight = maxHeight
        self.maxWidth = maxWidth
        self.subtitleFont = subtitleFont
        self.titleFont = titleFont
        self.priceFont = dataFont
        self.fullScreen = fullScreen
        
        if fullScreen {
            self.edgesIgnored = .all
        } else {
            self.edgesIgnored = .bottom
        }
        
        switch style {
        case .custom(let customStyle):
            self.chartStyle = customStyle
        case .primary:
            self.chartStyle = Styles.lineChartStyleTwo
        case .secondary:
            self.chartStyle = Styles.lineChartStyleThree
        case .tertiary:
            self.chartStyle = Styles.lineChartStyleFour
        default:
            self.chartStyle = Styles.lineChartStyleOne
        }
    }
    
    
    public var body: some View {
//        GeometryReader { g in
//            if fullScreen {
//                LineChartView(data: self.data, title: self.title, legend: self.subTitle, style: self.chartStyle,  valueSpecifier: self.floatingPntNumberFormat, cursorColor: self.cursorColor, curvedLines: self.curvedLines, displayChartStats: self.displayChartStats, width: g.size.width, height: g.size.height, titleFont: self.titleFont, subtitleFont: self.subtitleFont, priceFont: self.priceFont)
//                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                    .background(self.chartStyle.backgroundColor)
//                    .edgesIgnoringSafeArea(.all)
//            } else if (width == nil && height != nil) {
//                LineChartView(data: self.data, title: self.title, legend: self.subTitle, style: self.chartStyle,  valueSpecifier: self.floatingPntNumberFormat, cursorColor: self.cursorColor, curvedLines: self.curvedLines, displayChartStats: self.displayChartStats, width: g.size.width, height: self.height!, titleFont: self.titleFont, subtitleFont: self.subtitleFont, priceFont: self.priceFont)
//            } else if (width != nil && height != nil) {
//                LineChartView(data: self.data, title: self.title, legend: self.subTitle, style: self.chartStyle,  valueSpecifier: self.floatingPntNumberFormat, cursorColor: self.cursorColor, curvedLines: self.curvedLines, displayChartStats: self.displayChartStats, width:self.width!, height: self.height!, titleFont: self.titleFont, subtitleFont: self.subtitleFont, priceFont: self.priceFont)
//            } else if (width != nil && height == nil) {
//                LineChartView(data: self.data, title: self.title, legend: self.subTitle, style: self.chartStyle,  valueSpecifier: self.floatingPntNumberFormat, cursorColor: self.cursorColor, curvedLines: self.curvedLines, displayChartStats: self.displayChartStats, width:self.width!, height: g.size.width, titleFont: self.titleFont, subtitleFont: self.subtitleFont, priceFont: self.priceFont)
//            } else {
//                LineChartView(data: self.data, title: self.title, legend: self.subTitle, style: self.chartStyle,  valueSpecifier: self.floatingPntNumberFormat, cursorColor: self.cursorColor, curvedLines: self.curvedLines, displayChartStats: self.displayChartStats, width: g.size.width, height: (g.size.height), titleFont: self.titleFont, subtitleFont: self.subtitleFont, priceFont: self.priceFont)
//            }
//        }
        LineChartView(data: self.data, title: self.title, legend: self.subTitle, style: self.chartStyle,  valueSpecifier: self.floatingPntNumberFormat, cursorColor: self.cursorColor, curvedLines: self.curvedLines, displayChartStats: self.displayChartStats, minWidth: self.minWidth, minHeight: self.minHeight, maxWidth: self.maxWidth, maxHeight: maxHeight, titleFont: self.titleFont, subtitleFont: self.subtitleFont, priceFont: self.priceFont, fullScreen: self.fullScreen)
//            .background(self.chartStyle.backgroundColor)
//            .edgesIgnoringSafeArea(self.edgesIgnored)
//            .padding()
            
    }
}


public enum LineChartStyle {
    case primary
    case secondary
    case tertiary
    case custom(ChartStyle)
}

public enum BarChartStyle {
    case barChartStyleOrangeLight
    case barChartStyleOrangeDark
    case barChartStyleNeonBlueLight
    case barChartStyleNeonBlueDark
    case barChartMidnightGreenDark
    case barChartMidnightGreenLight
    case custom(ChartStyle)
}

public enum PieChartStyle {
    case pieChartStyleOne
    case custom(ChartStyle)
}


public var myStyle: ChartStyle = ChartStyle(
    backgroundColor: Color.white,
    accentColor: Colors.OrangeStart,
    secondGradientColor: Colors.OrangeEnd,
    textColor: Color.black,
    legendTextColor: Color.gray,
    dropShadowColor: Color.gray)

