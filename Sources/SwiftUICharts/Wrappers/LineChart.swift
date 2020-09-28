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
    
    private var chartStyle: ChartStyle = Styles.lineChartStyleOne
    
    public init (data: [Double],
                 title: String? = nil,
                 subTitle: String? = nil,
                 displayHorizontalLines: Bool = true,
                 style: LineChartStyle? = .lineChartStyleOne,
                 floatingPntNumberFormat: String = "%.1f") {
        // Assign data
        self.data = data
        self.title = title
        self.subTitle = subTitle
        self.displayHorizontalLines = displayHorizontalLines
        self.floatingPntNumberFormat = floatingPntNumberFormat
        
        switch style {
        case .lineChartStyleOne:
            self.chartStyle = Styles.lineChartStyleOne
        case .lineViewDarkMode:
            self.chartStyle = Styles.lineViewDarkMode
        case .custom(let customStyle):
            self.chartStyle = customStyle
        default:
            self.chartStyle = Styles.lineChartStyleOne
        }
    }
    
    
    public var body: some View {
        LineChartView(data: self.data, title: self.title, legend: self.subTitle, style: self.chartStyle, valueSpecifier: self.floatingPntNumberFormat)
    }
}

//struct ContentTest: View {
//    var body: some View {
//        LineChart(data: [], title: "test", subTitle: "Blah", displayHorizontalLines: false, style: .custom(ChartStyle(backgroundColor: Color.blue, accentColor: Color.blue, gradientColor: GradientColor(start: Color.green, end: Color.blue), textColor: Color.blue, legendTextColor: Color.blue, dropShadowColor: Color.blue)))
//    }
//}

public enum LineChartStyle {
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

