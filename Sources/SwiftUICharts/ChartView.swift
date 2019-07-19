//
//  ChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct Form {
    public static let small = CGSize(width:180, height:120)
    public static let medium = CGSize(width:180, height:240)
    public static let large = CGSize(width:360, height:120)
    public static let detail = CGSize(width:180, height:120)
}

public struct ChartView : View {
    public var data: [Int]
    public var title: String
    public var legend: String?
    public var backgroundColor:Color
    public var accentColor:Color
    public var formSize:CGSize
    var isFullWidth:Bool {
        return self.formSize == Form.large
    }
    public init(data: [Int], title: String, legend: String? = nil,backgroundColor:Color = Colors.color1,accentColor:Color = Colors.color1Accent, form: CGSize = Form.medium ){
        self.data = data
        self.title = title
        self.legend = legend
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        self.formSize = form
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
                    if(self.formSize == Form.large && self.legend != nil) {
                        Text(self.legend!)
                            .font(.callout)
                            .foregroundColor(self.accentColor)
                    }
                    Spacer()
                    Image(systemName: "waveform.path.ecg")
                        .imageScale(.large)
                        .foregroundColor(self.accentColor)
                    }.padding()
                ChartRow(data: data)
                    .foregroundColor(self.accentColor)
                    .clipped()
                if self.legend != nil  && self.formSize == Form.medium {
                    Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.accentColor)
                        .padding()
                }
            }
            }.frame(minWidth: self.formSize.width, maxWidth: self.isFullWidth ? .infinity : self.formSize.width, minHeight: self.formSize.height, maxHeight: self.formSize.height)
    }
}

#if DEBUG
struct ChartView_Previews : PreviewProvider {
    static var previews: some View {
        ChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", legend: "Legendary")
    }
}
#endif
