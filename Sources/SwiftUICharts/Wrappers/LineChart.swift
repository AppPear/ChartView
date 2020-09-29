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
    public var displayHorizontalLines: Bool
    public var floatingPntNumberFormat: String
    public var cursorColor: Color
    public var curvedLines: Bool
    public var displayChartStats: Bool
    public var width: CGFloat
    public var height: CGFloat
    
    public var titleFont: Font
    public var subtitleFont: Font
    public var priceFont: Font
    
    private var chartStyle: ChartStyle = Styles.lineChartStyleOne
    
    public init (data: [Double],
                 title: String? = nil,
                 subTitle: String? = nil,
                 displayHorizontalLines: Bool = true,
                 style: LineChartStyle? = .primary,
                 curvedLines: Bool = true,
                 cursorColor: Color = Colors.IndicatorKnob,
                 displayChartStats: Bool = true,
                 width: CGFloat = 360,
                 height: CGFloat = 360,
                 titleFont: Font = .system(size: 30, weight: .regular, design: .rounded),
                 subtitleFont: Font = .system(size: 14, weight: .light, design: .rounded),
                 priceFont: Font = .system(size: 16, weight: .bold, design: .monospaced),
                 floatingPntNumberFormat: String = "%.1f") {
        
        // Assign data
        self.data = data
        self.title = title
        self.subTitle = subTitle
        self.displayHorizontalLines = displayHorizontalLines
        self.floatingPntNumberFormat = floatingPntNumberFormat
        self.cursorColor = cursorColor
        self.curvedLines = curvedLines
        self.displayChartStats = displayChartStats
        self.width = width
        self.height = height
        self.subtitleFont = subtitleFont
        self.titleFont = titleFont
        self.priceFont = priceFont
        
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
        LineChartView(data: self.data, title: self.title, legend: self.subTitle, style: self.chartStyle,  valueSpecifier: self.floatingPntNumberFormat, cursorColor: self.cursorColor, curvedLines: self.curvedLines, displayChartStats: self.displayChartStats, width: self.width, height: self.height, titleFont: self.titleFont, subtitleFont: self.subtitleFont, priceFont: self.priceFont)
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

