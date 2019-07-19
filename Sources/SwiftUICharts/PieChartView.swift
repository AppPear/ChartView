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
    public var backgroundColor:Color
    public var accentColor:Color
    
    public init(data: [Int], title: String, legend: String? = nil, backgroundColor:Color = Colors.color3,accentColor:Color = Colors.color3Accent){
        self.data = data
        self.title = title
        self.legend = legend
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
    }
    
    public var body: some View {
        ZStack{
            Rectangle()
                .fill(self.backgroundColor)
                .cornerRadius(20)
            VStack(alignment: .leading){
                HStack{
                    Text(self.title)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chart.pie.fill")
                        .imageScale(.large)
                        .foregroundColor(self.accentColor)
                    }.padding()
                PieChartRow(data: data, backgroundColor: self.backgroundColor, accentColor: self.accentColor)
                    .foregroundColor(self.accentColor).padding(self.legend != nil ? 0 : 12).offset(y:self.legend != nil ? 0 : -10)
                if(self.legend != nil) {
                    Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.accentColor)
                        .padding()
                }
                
            }
            }.frame(width: 200, height: 240)
    }
}

#if DEBUG
struct PieChartView_Previews : PreviewProvider {
    static var previews: some View {
        PieChartView(data:[56,78,53], title: "Title", legend: "Legend")
    }
}
#endif
