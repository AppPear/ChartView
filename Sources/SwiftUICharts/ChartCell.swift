//
//  ChartCell.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct ChartCell : View {
    var value: Double
    var index: Int = 0
    @State var scaleValue: Double = 0
    public var body: some View {
        Rectangle()
            .frame(width: 6)
            .cornerRadius(4)
            .scaleEffect(CGSize(width: 1, height: self.scaleValue), anchor: .bottom)
            .onAppear(){
                self.scaleValue = self.value
            }
            .animation(Animation.spring().delay(Double(self.index) * 0.04))
    }
}

#if DEBUG
struct ChartCell_Previews : PreviewProvider {
    static var previews: some View {
        ChartCell(value: Double(0.75))
    }
}
#endif
