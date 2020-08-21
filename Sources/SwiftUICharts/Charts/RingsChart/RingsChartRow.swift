//
//  RingsChartRow.swift
//  ChartViewV2Demo
//
//  Created by Dan Wood on 8/20/20.
//

import SwiftUI

public struct RingsChartRow: View {
	@EnvironmentObject var chartValue: ChartValue
	@ObservedObject var chartData: ChartData
	@State var touchLocation: CGFloat = -1.0

	enum Constant {
		static let spacing: CGFloat = 16.0
	}

	var style: ChartStyle

	var maxValue: Double {
		guard let max = chartData.data.max() else {
			return 1
		}
		return max != 0 ? max : 1
	}

	public var body: some View {
		GeometryReader { geometry in
			ZStack {
				ForEach(0..<self.chartData.data.count, id: \.self) { index in
					Ring(ringWidth: 20, percent: self.chartData.data[index], backgroundColor: self.style.backgroundColor, foregroundColor:self.style.foregroundColor.rotate(for: index))
//					value: self.normalizedValue(index: index),
//								 index: index,
//								 width: Float(geometry.frame(in: .local).width - Constant.spacing),
//								 numberOfDataPoints: self.chartData.data.count,
//								 gradientColor: self.style.foregroundColor.rotate(for: index),
//								 touchLocation: self.touchLocation)
						.padding(20.0 * CGFloat(index))
						.scaleEffect(self.getScaleSize(touchLocation: self.touchLocation, index: index), anchor: .center)
						.animation(Animation.easeIn(duration: 0.2))
				}
				//                   .drawingGroup()
			}
//			.padding([.top, .leading, .trailing], 10)
		}
	}

	func normalizedValue(index: Int) -> Double {
		return Double(chartData.data[index])/Double(maxValue)
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
											 ColorGradient(.red, .purple),
											 ColorGradient(.yellow, .orange),
											])

		return RingsChartRow(chartData: ChartData([25,50,75,100,125,150]), style: multiStyle)
	}
}
