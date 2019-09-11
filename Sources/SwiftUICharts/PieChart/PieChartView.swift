//
//  PieChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartView : View {
    public var data: [Int]
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public init(data: [Int], title: String, legend: String? = nil, style: ChartStyle = Styles.pieChartStyleOne ){
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
    }
    
    public var body: some View {
        ZStack{
            Rectangle()
                .fill(self.style.backgroundColor)
                .cornerRadius(20)
                .shadow(color: Color.gray, radius: 12)
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
                PieChartRow(data: data, backgroundColor: self.style.backgroundColor, accentColor: self.style.accentColor)
                    .foregroundColor(self.style.accentColor).padding(self.legend != nil ? 0 : 12).offset(y:self.legend != nil ? 0 : -10)
                if(self.legend != nil) {
                    Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.style.legendTextColor)
                        .padding()
                }
                
            }
        }.frame(width: self.style.chartFormSize.width, height: self.style.chartFormSize.height)
    }
}

#if DEBUG
struct PieChartView_Previews : PreviewProvider {
    static var previews: some View {
        PieChartView(data:[56,78,53,65,54], title: "Title", legend: "Legend")
    }
}
#endif
