//
//  RingsChartRow.swift
//  ChartViewV2Demo
//
//  Created by Dan Wood on 8/20/20.
//

import SwiftUI

public struct RingsChartRow: View {

	var width : CGFloat
	var spacing : CGFloat

	@EnvironmentObject var chartValue: ChartValue
	@ObservedObject var chartData: ChartData
	@State var touchRadius: CGFloat = -1.0

	var style: ChartStyle

	public var body: some View {
		GeometryReader { geometry in

			ZStack {

				// FIXME: Why is background circle offset strangely when frame isn't specified? See Preview below. Related to the .animation somehow ????
				Circle()
					.fill(RadialGradient(gradient: self.style.backgroundColor.gradient, center: .center, startRadius: min(geometry.size.width, geometry.size.height)/2.0, endRadius: 1.0))

				ForEach(0..<self.chartData.data.count, id: \.self) { index in
					Ring(ringWidth: width, percent: self.chartData.data[index], foregroundColor:self.style.foregroundColor.rotate(for: index),
								 touchRadius: self.touchRadius)

						.padding(min(
							(width + spacing) * CGFloat(index),	// expected padding
									 min(geometry.size.width, geometry.size.height)/2.0 - width
										// make sure it doesn't get to crazy value
									 ))

						.scaleEffect(self.getScaleSize(size:geometry.size, touchRadius: self.touchRadius, index: index), anchor: .center)
						.animation(Animation.easeIn(duration: 1.0))
				}
				//                   .drawingGroup()
			}

			.gesture(DragGesture()
						.onChanged({ value in
							let frame = geometry.frame(in: .local)
							let radius = min(frame.width, frame.height) / 2.0
							let deltaX = value.location.x - frame.midX
							let deltaY = value.location.y - frame.midY
							self.touchRadius = sqrt(deltaX*deltaX + deltaY*deltaY) // Pythagorean equation

							if let currentValue = self.getCurrentValue(maxRadius: radius) {
								self.chartValue.currentValue = currentValue
								self.chartValue.interactionInProgress = true
							}
						})
						.onEnded({ value in
							self.chartValue.interactionInProgress = false
							self.touchRadius = -1
						})
			)

		}
	}

	/// Scale up the touched ring
	/// - Parameters:
	///   - size: size of the view
	///   - touchRadius: distance from center where touched
	///   - index: which ring is being drawn
	/// - Returns: size to scale up or just scale of 1 if not scaled up
	func getScaleSize(size: CGSize, touchRadius: CGFloat, index: Int) -> CGSize {
		let radius = min(size.width, size.height) / 2.0
		if self.touchedCircleIndex(maxRadius: radius) != nil {
			return CGSize(width: 1.4, height: 1.4)
		}
		return CGSize(width: 1, height: 1)
	}

	/// Find which circle has been touched
	/// - Parameter maxRadius: radius of overall view circle
	/// - Returns: which circle index was touched, if found. 0 = outer, 1 = next one in, etc.
	func touchedCircleIndex(maxRadius: CGFloat) -> Int? {
		guard self.chartData.data.count > 0 else { return nil }	// no data

		// Pretend actual circle goes ½ the inter-ring spacing out, so that a touch
		// is registered on either side of each ring
		let radialDistanceFromEdge = (maxRadius + spacing/2) - self.touchRadius;
		guard radialDistanceFromEdge >= 0 else { return nil }	// touched outside of ring

		let touchIndex = Int(floor(radialDistanceFromEdge / (width + spacing)))

		if touchIndex >= self.chartData.data.count { return nil }	// too far from outside, no ring

		return touchIndex
	}

	/// Description
	/// - Parameter maxRadius: radius of overall view circle
	/// - Returns: percentage value of the touched circle, based on `touchRadius` if found
	func getCurrentValue(maxRadius: CGFloat) -> Double? {

		guard let index = self.touchedCircleIndex(maxRadius: maxRadius) else { return nil }
		return self.chartData.data[index]
	}
}


struct RingsChartRow_Previews: PreviewProvider {
	static var previews: some View {

		let multiStyle = ChartStyle(backgroundColor: ColorGradient(Color.black.opacity(0.05), Color.white),
										   foregroundColor:
											[ColorGradient(.purple, .blue),
											 ColorGradient(.orange, .red),
											 ColorGradient(.green, .yellow),
											])

		return RingsChartRow(width:20.0, spacing:10.0, chartData: ChartData([25,50,75,100,125]), style: multiStyle)

		// and why does this not get centered when frame IS specified?
		.frame(width:300, height:400)
	}
}
