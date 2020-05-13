//
//  PieChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartView : View {
    public var data: [Double]
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var formSize:CGSize
    public var dropShadow: Bool

    public init(data: [Double], title: String, legend: String? = nil, style: ChartStyle = Styles.pieChartStyleOne, form: CGSize? = ChartForm.medium, dropShadow: Bool? = true){
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.formSize = form!
        self.dropShadow = dropShadow!
    }
    
    public var body: some View {
        ZStack{
            Rectangle()
                .fill(self.style.backgroundColor)
                .cornerRadius(20)
                .shadow(color: self.style.dropShadowColor, radius: self.dropShadow ? 12 : 0)
            VStack(alignment: .leading){
                HStack{
                    Text(self.title)
                        .font(.headline)
                        .foregroundColor(self.style.textColor)
                    Spacer()
                    Image(systemName: "chart.pie.fill")
                        .imageScale(.large)
                        .foregroundColor(self.style.legendTextColor)
                }.padding()
                PieChartRow(data: data, backgroundColor: self.style.backgroundColor, accentColors: self.style.accentColors)
                    .foregroundColor(self.style.accentColor).padding(self.legend != nil ? 0 : 12).offset(y:self.legend != nil ? 0 : -10)
                if(self.legend != nil) {
                    Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.style.legendTextColor)
                        .padding()
                }
                
            }
        }.frame(width: self.formSize.width, height: self.formSize.height)
    }
}

#if DEBUG
struct PieChartView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            
            //Default
            PieChartView(data:[56,78,53,65,54], title: "Title", legend: "Legend")
            
            //1 Accent Color
            PieChartView(data:[56,78,53,65,54], title: "", style: styleOneAccentColor )
            
            //2 Accent Color
            PieChartView(data:[56,78,53,65,54], title: "", style: styleTwoAccentColor )
            
            //N Accent Color
            PieChartView(data:[56,78,53,65,54], title: "", style: styleFiveAccentColor )
            
        }.previewLayout(.fixed(width: 250, height: 400))
    }
}

private let styleOneAccentColor = ChartStyle(
    backgroundColor: Color.white,
    accentColor: Color.yellow,
    secondGradientColor: Colors.OrangeStart,
    textColor: Color.black,
    legendTextColor: Color.gray,
    dropShadowColor: Color.gray)

private let styleTwoAccentColor = ChartStyle(
   backgroundColor: Color.white,
   accentColors: [Color.yellow, Color.red],
   secondGradientColor: Colors.OrangeStart,
   textColor: Color.black,
   legendTextColor: Color.gray,
   dropShadowColor: Color.gray)

private let styleFiveAccentColor = ChartStyle(
backgroundColor: Color.white,
accentColors: [Color.yellow, Color.red, Color.blue, Color.purple, Color.green],
secondGradientColor: Colors.OrangeStart,
textColor: Color.black,
legendTextColor: Color.gray,
dropShadowColor: Color.gray)

#endif
