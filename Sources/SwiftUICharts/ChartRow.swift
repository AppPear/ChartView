//
//  ChartRow.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct ChartRow : View {
    var data: [Int]
    var maxValue: Int {
        data.max() ?? 0
    }
    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: (geometry.frame(in: .local).width-22)/CGFloat(self.data.count * 3)){
                ForEach(0..<self.data.count) { i in
                    ChartCell(value: Double(self.data[i])/Double(self.maxValue), index: i, width: Float(geometry.frame(in: .local).width - 22), numberOfDataPoints: self.data.count)
                }
            }
            .padding([.trailing,.leading], 13)
        }
    }
}

#if DEBUG
struct ChartRow_Previews : PreviewProvider {
    static var previews: some View {
        ChartRow(data: [8,23,54,32,12,37,7])
    }
}
#endif
