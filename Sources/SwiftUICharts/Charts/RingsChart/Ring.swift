//
//  Ring.swift
//  ChartViewV2Demo
//
//  Created by Dan Wood on 8/20/20.
//	Based on article and playground code by Frank Jia
//	https://medium.com/@frankjia/creating-activity-rings-in-swiftui-11ef7d336676

import SwiftUI


extension Double {
	func toRadians() -> Double {
		return self * Double.pi / 180
	}
	func toCGFloat() -> CGFloat {
		return CGFloat(self)
	}
}

struct RingShape: Shape {
	// Helper function to convert percent values to angles in degrees
	static func percentToAngle(percent: Double, startAngle: Double) -> Double {
		(percent / 100 * 360) + startAngle
	}
	private var percent: Double
	private var startAngle: Double
	private let drawnClockwise: Bool

	// This allows animations to run smoothly for percent values
	var animatableData: Double {
		get {
			return percent
		}
		set {
			percent = newValue
		}
	}

	init(percent: Double = 100, startAngle: Double = -90, drawnClockwise: Bool = false) {
		self.percent = percent
		self.startAngle = startAngle
		self.drawnClockwise = drawnClockwise
	}

	// This draws a simple arc from the start angle to the end angle
	func path(in rect: CGRect) -> Path {
		let width = rect.width
		let height = rect.height
		let radius = min(width, height) / 2
		let center = CGPoint(x: width / 2, y: height / 2)
		let endAngle = Angle(degrees: RingShape.percentToAngle(percent: self.percent, startAngle: self.startAngle))
		return Path { path in
			path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startAngle), endAngle: endAngle, clockwise: drawnClockwise)
		}
	}
}

struct Ring: View {

	private static let ShadowColor: Color = Color.black.opacity(0.2)
	private static let ShadowRadius: CGFloat = 5
	private static let ShadowOffsetMultiplier: CGFloat = ShadowRadius + 2

	private let ringWidth: CGFloat
	private let percent: Double
	private let backgroundColor: ColorGradient
	private let foregroundColor: ColorGradient
	private let startAngle: Double = -90
	private var gradientStartAngle: Double {
		self.percent >= 100 ? relativePercentageAngle - 360 : startAngle
	}
	private var absolutePercentageAngle: Double {
		RingShape.percentToAngle(percent: self.percent, startAngle: 0)
	}
	private var relativePercentageAngle: Double {
		// Take into account the startAngle
		absolutePercentageAngle + startAngle
	}
	private var lastGradientColor: Color {
		self.foregroundColor.endColor
	}
	private var backgroundGradient: AngularGradient {
		AngularGradient(
			gradient: self.backgroundColor.gradient,
			center: .center,
			startAngle: Angle(degrees: 0),
			endAngle: Angle(degrees: 360)
		)
	}

	private var ringGradient: AngularGradient {
		AngularGradient(
			gradient: self.foregroundColor.gradient,
			center: .center,
			startAngle: Angle(degrees: self.gradientStartAngle),
			endAngle: Angle(degrees: relativePercentageAngle)
		)
	}

	init(ringWidth: CGFloat, percent: Double, backgroundColor: ColorGradient, foregroundColor: ColorGradient) {
		self.ringWidth = ringWidth
		self.percent = percent
		self.backgroundColor = backgroundColor
		self.foregroundColor = foregroundColor
	}

	var body: some View {
		GeometryReader { geometry in
			ZStack {
				// Background for the ring
				RingShape()
					.stroke(style: StrokeStyle(lineWidth: self.ringWidth))
					.fill(self.backgroundGradient)
				// Foreground
				RingShape(percent: self.percent, startAngle: self.startAngle)
					.stroke(style: StrokeStyle(lineWidth: self.ringWidth, lineCap: .round))
					.fill(self.ringGradient)
				// End of ring with drop shadow
				if self.getShowShadow(frame: geometry.size) {
					Circle()
						.fill(self.lastGradientColor)
						.frame(width: self.ringWidth, height: self.ringWidth, alignment: .center)
						.offset(x: self.getEndCircleLocation(frame: geometry.size).0,
								y: self.getEndCircleLocation(frame: geometry.size).1)
						.shadow(color: Ring.ShadowColor,
								radius: Ring.ShadowRadius,
								x: self.getEndCircleShadowOffset().0,
								y: self.getEndCircleShadowOffset().1)
				}
			}
		}
		// Padding to ensure that the entire ring fits within the view size allocated
		.padding(self.ringWidth / 2)
	}

	private func getEndCircleLocation(frame: CGSize) -> (CGFloat, CGFloat) {
		// Get angle of the end circle with respect to the start angle
		let angleOfEndInRadians: Double = relativePercentageAngle.toRadians()
		let offsetRadius = min(frame.width, frame.height) / 2
		return (offsetRadius * cos(angleOfEndInRadians).toCGFloat(), offsetRadius * sin(angleOfEndInRadians).toCGFloat())
	}

	private func getEndCircleShadowOffset() -> (CGFloat, CGFloat) {
		let angleForOffset = absolutePercentageAngle + (self.startAngle + 90)
		let angleForOffsetInRadians = angleForOffset.toRadians()
		let relativeXOffset = cos(angleForOffsetInRadians)
		let relativeYOffset = sin(angleForOffsetInRadians)
		let xOffset = relativeXOffset.toCGFloat() * Ring.ShadowOffsetMultiplier
		let yOffset = relativeYOffset.toCGFloat() * Ring.ShadowOffsetMultiplier
		return (xOffset, yOffset)
	}

	private func getShowShadow(frame: CGSize) -> Bool {
		if self.percent >= 100 {
			return true
		}
		let circleRadius = min(frame.width, frame.height) / 2
		let remainingAngleInRadians = (360 - absolutePercentageAngle).toRadians().toCGFloat()

		return circleRadius * remainingAngleInRadians <= self.ringWidth
	}
}

struct Ring_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			Ring(
				ringWidth: 50, percent: 5 ,
				backgroundColor: ColorGradient(Color.green.opacity(0.2)),
				foregroundColor: ColorGradient(.green, .blue)
			)
			.frame(width: 200, height: 200)

			Ring(
				ringWidth: 20, percent: 110 ,
				backgroundColor: ColorGradient(Color.black.opacity(0.2)),
				foregroundColor: ColorGradient(.red, .blue)
			)
			.frame(width: 200, height: 200)



		}
	}
}
