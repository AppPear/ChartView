//
//  PieChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
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
        if self.formSize == ChartForm.large {
            self.formSize = ChartForm.extraLarge
        }
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
                    #if os(macOS)
                    #else
                    Image(systemName: "chart.pie.fill")
                        .imageScale(.large)
                        .foregroundColor(self.style.legendTextColor)
                    #endif
                }.padding()
                PieChartRow(data: data, backgroundColor: self.style.backgroundColor, accentColor: self.style.accentColor)
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
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PieChartView_Previews : PreviewProvider {
    static var previews: some View {
        PieChartView(data:[56,78,53,65,54], title: "Title", legend: "Legend")
    }
}
#endif
