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
        HStack(alignment: .bottom, spacing: 14){
            ForEach(0..<data.count) { i in
                ChartCell(value: Double(self.data[i])/Double(self.maxValue), index: i)
            }
        }.padding([.trailing,.leading])
    }
}

#if DEBUG
struct ChartRow_Previews : PreviewProvider {
    static var previews: some View {
        ChartRow(data: [8,23,54,32,12,37,7])
    }
}
#endif
