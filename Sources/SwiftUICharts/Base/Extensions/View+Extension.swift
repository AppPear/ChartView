import SwiftUI

extension View {

	/// Attach chart style to a View
	/// - Parameter style: chart style
	/// - Returns: `View` with chart style attached
    public func chartStyle(_ style: ChartStyle) -> some View {
        self.environmentObject(style)
    }

    public func toStandardCoordinateSystem() -> some View {
        self
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}
