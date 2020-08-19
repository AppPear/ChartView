import SwiftUI

extension View {

	/// <#Description#>
	/// - Parameter style: <#style description#>
	/// - Returns: <#description#>
    public func chartStyle(_ style: ChartStyle) -> some View {
        self.environmentObject(style)
    }
}
