//
//  IndicatorPoint.swift
//  LineChart
//
//  Created by András Samu on 2019. 09. 03..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct IndicatorPoint: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Colors.IndicatorKnob)
            Circle()
                .stroke(Color.white, style: StrokeStyle(lineWidth: 4))
        }
        .frame(width: 14, height: 14)
        .shadow(color: Colors.LegendColor, radius: 6, x: 0, y: 6)
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}
