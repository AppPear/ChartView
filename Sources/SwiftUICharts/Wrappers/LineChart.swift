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
    
    private var chartStyle: ChartStyle = Styles.lineChartStyleOne
    
    public init (data: [Double],
                 title: String? = nil,
                 subTitle: String? = nil,
                 displayHorizontalLines: Bool = true,
                 style: LineChartStyle? = .lineChartStyleOne,
                 curvedLines: Bool = true,
                 floatingPntNumberFormat: String = "%.1f",
                 cursorColor: Color = Colors.IndicatorKnob,
                 displayChartStats: Bool = true,
                 width: CGFloat = 360,
                 height: CGFloat = 360) {
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
        
        switch style {
        case .lineChartStyleOne:
            self.chartStyle = Styles.lineChartStyleOne
        case .lineViewDarkMode:
            self.chartStyle = Styles.lineViewDarkMode
        case .custom(let customStyle):
            self.chartStyle = customStyle
        case .primary:
            self.chartStyle = Styles.lineChartStyleTwo
        default:
            self.chartStyle = Styles.lineChartStyleOne
        }
    }
    
    public var body: some View {
        LineChartView(data: self.data, title: self.title, legend: self.subTitle, style: self.chartStyle,  valueSpecifier: self.floatingPntNumberFormat, cursorColor: self.cursorColor, curvedLines: self.curvedLines, displayChartStats: self.displayChartStats, width: self.width, height: self.height)
    }
}


public enum LineChartStyle {
    case primary
    case lineChartStyleOne
    case lineViewDarkMode
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

