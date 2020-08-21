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
	@State var touchLocation: CGFloat = -1.0

	var style: ChartStyle

	public var body: some View {
		GeometryReader { geometry in
			ZStack {
//				Circle()
//					.fill(self.style.backgroundColor.endColor)	// use gradient?

				ForEach(0..<self.chartData.data.count, id: \.self) { index in
					Ring(ringWidth: width, percent: self.chartData.data[index], backgroundColor: self.style.backgroundColor, foregroundColor:self.style.foregroundColor.rotate(for: index))
//								 touchLocation: self.touchLocation)
						.padding((width + spacing) * CGFloat(index))
						.scaleEffect(self.getScaleSize(touchLocation: self.touchLocation, index: index), anchor: .center)
						.animation(Animation.easeIn(duration: 0.2))
				}
				//                   .drawingGroup()
			}
		}
	}

	func getScaleSize(touchLocation: CGFloat, index: Int) -> CGSize {
		if touchLocation > CGFloat(index)/CGFloat(chartData.data.count) &&
			touchLocation < CGFloat(index+1)/CGFloat(chartData.data.count) {
			return CGSize(width: 1.4, height: 1.1)
		}
		return CGSize(width: 1, height: 1)
	}

	func getCurrentValue(width: CGFloat) -> Double? {
		guard self.chartData.data.count > 0 else { return nil}
		let index = max(0,min(self.chartData.data.count-1,Int(floor((self.touchLocation*width)/(width/CGFloat(self.chartData.data.count))))))
		return self.chartData.data[index]
	}
}


struct RingsChartRow_Previews: PreviewProvider {
	static var previews: some View {

		let multiStyle = ChartStyle(backgroundColor: .gray,
										   foregroundColor:
											[ColorGradient(.purple, .blue),
											 ColorGradient(.orange, .red),
											 ColorGradient(.green, .yellow),
											])

		return RingsChartRow(width:20.0, spacing:10.0, chartData: ChartData([25,50,75,100,125]), style: multiStyle)
	}
}
