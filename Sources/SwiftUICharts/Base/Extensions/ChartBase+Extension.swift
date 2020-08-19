import SwiftUI

extension View where Self: ChartBase {
	
	/// Set data for a chart
	/// - Parameter data: array of `Double`
	/// - Returns: modified `View` with data attached
    public func data(_ data: [Double]) -> some View {
        chartData.data = data
        return self
            .environmentObject(chartData)
            .environmentObject(ChartValue())
    }
}
