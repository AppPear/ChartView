import SwiftUI

extension View {

	/// Attach chart style to a View
	/// - Parameter style: chart style
	/// - Returns: `View` with chart style attached
    public func chartStyle(_ style: ChartStyle) -> some View {
        self.environmentObject(style)
    }
}
