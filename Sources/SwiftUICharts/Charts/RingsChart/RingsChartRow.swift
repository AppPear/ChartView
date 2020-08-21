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
					Ring()
//					value: self.normalizedValue(index: index),
//								 index: index,
//								 width: Float(geometry.frame(in: .local).width - Constant.spacing),
//								 numberOfDataPoints: self.chartData.data.count,
//								 gradientColor: self.style.foregroundColor.rotate(for: index),
//								 touchLocation: self.touchLocation)
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

