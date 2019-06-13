//
//  ChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct ChartView : View {
    public var data: [Int]
    public var title: String
    public var legend: String?
    public var backgroundColor:Color
    public var accentColor:Color
    
    public init(data: [Int], title: String, legend: String? = nil,backgroundColor:Color = Color(red: 238.0/255.0, green: 241.0/255.0, blue: 254.0/255.0),accentColor:Color = Color(red: 66.0/255.0, green: 102.0/255.0, blue: 232.0/255.0) ){
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
                    Image(systemName: "waveform.path.ecg")
                    .imageScale(.large)
                    .foregroundColor(self.accentColor)
                }.padding()
                ChartRow(data: data)
                .foregroundColor(self.accentColor)
                if self.legend != nil {
                    Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.accentColor)
                        .padding()
                }
            }
            }.frame(width: 180, height: 240)
    }
}

#if DEBUG
struct ChartView_Previews : PreviewProvider {
    static var previews: some View {
        ChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title")
    }
}
#endif
