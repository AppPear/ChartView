import SwiftUI

extension View where Self: ChartBase {
	
	/// <#Description#>
	/// - Parameter data: <#data description#>
	/// - Returns: <#description#>
    public func data(_ data: [Double]) -> some View {
        chartData.data = data
        return self
            .environmentObject(chartData)
            .environmentObject(ChartValue())
    }
}
