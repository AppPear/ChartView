//
//  File.swift
//  
//
//  Created by András Samu on 2019. 07. 19..
//

import Foundation
import SwiftUI

public struct Colors {
    public static let color1:Color = Color(hexString: "#E2FAE7")
    public static let color1Accent:Color = Color(hexString: "#72BF82")
    public static let color2:Color = Color(hexString: "#EEF1FF")
    public static let color2Accent:Color = Color(hexString: "#4266E8")
    public static let color3:Color = Color(hexString: "#FCECEA")
    public static let color3Accent:Color = Color(hexString: "#E1614C")
    public static let OrangeStart:Color = Color(hexString: "#FF782C")
    public static let OrangeEnd:Color = Color(hexString: "#EC2301")
    public static let LegendText:Color = Color(hexString: "#A7A6A8")
    public static let LegendColor:Color = Color(hexString: "#E8E7EA")
    public static let IndicatorKnob:Color = Color(hexString: "#FF57A6")
    public static let GradientUpperBlue:Color = Color(hexString: "#C2E8FF")
    public static let GradinetUpperBlue1:Color = Color(hexString: "#A8E1FF")
    public static let GradientPurple:Color = Color(hexString: "#7B75FF")
    public static let GradientNeonBlue:Color = Color(hexString: "#6FEAFF")
    public static let GradientLowerBlue:Color = Color(hexString: "#F1F9FF")
    public static let DarkPurple:Color = Color(hexString: "#1B205E")
    public static let BorderBlue:Color = Color(hexString: "#4EBCFF")
    
    
}

public struct Styles {
    public static let lineChartStyleOne = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        chartFormSize: Form.medium,
        textColor: Color.black,
        legendTextColor: Color.gray)
    
    public static let barChartStyleOne = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        chartFormSize: Form.medium,
        textColor: Color.black,
        legendTextColor: Color.gray)
    
    public static let barChartStyleTwo = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.GradientNeonBlue,
        secondGradientColor: Colors.GradientPurple,
        chartFormSize: Form.medium,
        textColor: Color.black,
        legendTextColor: Color.gray)
    
    public static let barChartStyleThree = ChartStyle(
        backgroundColor: Color.black,
        accentColor: Colors.GradientNeonBlue,
        secondGradientColor: Colors.GradientPurple,
        chartFormSize: Form.medium,
        textColor: Color.white,
        legendTextColor: Color.gray)
    
    public static let barChartMidnightGreen = ChartStyle(
        backgroundColor: Color(hexString: "#3B5147"), //3B5147, 313D34
        accentColor: Color(hexString: "#FFD603"),
        secondGradientColor: Color(hexString: "#FFCA04"),
        chartFormSize: Form.medium,
        textColor: Color.white,
        legendTextColor: Color(hexString: "#D2E5E1"))
    
    public static let barChartMidnightGreenLight = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Color(hexString: "#84A094"), //84A094 , 698378
        secondGradientColor: Color(hexString: "#50675D"),
        chartFormSize: Form.medium,
        textColor: Color.black,
        legendTextColor:Color.gray)
    
    public static let pieChartStyleOne = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        chartFormSize: Form.medium,
        textColor: Color.black,
        legendTextColor: Color.gray)
}

public struct Form {
    public static let small = CGSize(width:180, height:120)
    public static let medium = CGSize(width:180, height:240)
    public static let large = CGSize(width:360, height:120)
    public static let detail = CGSize(width:180, height:120)
}

public struct ChartStyle {
    public var backgroundColor: Color
    public var accentColor: Color
    public var secondGradientColor: Color
    public var chartFormSize: CGSize
    public var textColor: Color
    public var legendTextColor: Color
    
    public init(backgroundColor: Color, accentColor: Color, secondGradientColor: Color, chartFormSize: CGSize, textColor: Color, legendTextColor: Color){
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        self.secondGradientColor = secondGradientColor
        self.chartFormSize = chartFormSize
        self.textColor = textColor
        self.legendTextColor = legendTextColor
    }
    
    public init(formSize: CGSize){
        self.backgroundColor = Color.white
        self.accentColor = Colors.OrangeStart
        self.secondGradientColor = Colors.OrangeEnd
        self.chartFormSize = formSize
        self.legendTextColor = Color.gray
        self.textColor = Color.black
    }
}

class ChartData: ObservableObject {
    @Published var points: [Int] = [Int]()
    @Published var currentPoint: Int? = nil
    
    init(points:[Int]) {
        self.points = points
    }
}

class TestData{
    static public var data:ChartData = ChartData(points: [37,72,51,22,39,47,66,85,50])
}

extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}
