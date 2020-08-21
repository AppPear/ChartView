//
//  Ring.swift
//  ChartViewV2Demo
//
//  Created by Dan Wood on 8/20/20.
//

import SwiftUI

struct Ring: View {

	@State private var stroke : CGFloat = 16.0
	@State private var fraction : CGFloat = 0.75
    var body: some View {
        Circle()
			.fill(Color.white)
			.overlay(
				Circle()
					.trim(from:0, to:fraction)
					.stroke(style: StrokeStyle(lineWidth:stroke, lineCap: .round, lineJoin: .round))
					.fill(AngularGradient(gradient: .init(colors:[.red, .orange]), center: .center, startAngle:.zero, endAngle: .init(degrees:360)))
					.rotationEffect(Angle(degrees: 270.0))
			)
			.padding(stroke/2.0)
			.animation(.spring(response:1.0, dampingFraction:1.0, blendDuration:1.0))
    }
}

struct RingChart_Previews: PreviewProvider {
    static var previews: some View {
        Ring()
			.padding()
    }
}
