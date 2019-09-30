//
//  ChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct BarChartView : View {
    public var data: [Int]
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var formSize:CGSize
//    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    @State private var touchLocation: CGFloat = -1.0
    @State private var showValue: Bool = false
    @State private var currentValue: Int = 0 {
        didSet{
            if(oldValue != self.currentValue && self.showValue) {
//                selectionFeedbackGenerator.selectionChanged()
                HapticFeedback.playSelection()
            }
        }
    }
    var isFullWidth:Bool {
        return self.formSize == Form.large
    }
    public init(data: [Int], title: String, legend: String? = nil, style: ChartStyle = Styles.barChartStyleOrangeLight, form: CGSize? = Form.medium){
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.formSize = form!
    }
    
    public var body: some View {
        ZStack{
            Rectangle()
                .fill(self.style.backgroundColor)
                .cornerRadius(20)
                .shadow(color: Color.gray, radius: 8 )
            VStack(alignment: .leading){
                HStack{
                    if(!showValue){
                        Text(self.title)
                            .font(.headline)
                            .foregroundColor(self.style.textColor)
                    }else{
                        Text("\(self.currentValue)")
                            .font(.headline)
                            .foregroundColor(self.style.textColor)
                    }
                    if(self.formSize == Form.large && self.legend != nil && !showValue) {
                        Text(self.legend!)
                            .font(.callout)
                            .foregroundColor(self.style.accentColor)
                            .transition(.opacity)
                            .animation(.easeOut)
                    }
                    Spacer()
                    Image(systemName: "waveform.path.ecg")
                        .imageScale(.large)
                        .foregroundColor(self.style.legendTextColor)
                }.padding()
                BarChartRow(data: data, accentColor: self.style.accentColor, secondGradientAccentColor: self.style.secondGradientColor, touchLocation: self.$touchLocation)
                if self.legend != nil  && self.formSize == Form.medium {
                    Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.style.legendTextColor)
                        .padding()
                }
                
            }
        }.frame(minWidth:self.formSize.width, maxWidth: self.isFullWidth ? .infinity : self.formSize.width, minHeight:self.formSize.height, maxHeight:self.formSize.height)
            .gesture(DragGesture()
                .onChanged({ value in
                    self.touchLocation = value.location.x/self.formSize.width
                    self.showValue = true
                    self.currentValue = self.getCurrentValue()
                })
                .onEnded({ value in
                    self.showValue = false
                    self.touchLocation = -1
                })
        )
            .gesture(TapGesture()
        )
    }
    
    func getCurrentValue()-> Int{
        let index = max(0,min(self.data.count-1,Int(floor((self.touchLocation*self.formSize.width)/(self.formSize.width/CGFloat(self.data.count))))))
        print(index)
        return self.data[index]
    }
}

#if DEBUG
struct ChartView_Previews : PreviewProvider {
    static var previews: some View {
        BarChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", legend: "Legendary")
    }
}
#endif
