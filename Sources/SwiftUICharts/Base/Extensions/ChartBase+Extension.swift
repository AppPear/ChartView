import SwiftUI

extension View where Self: ChartBase {
	
	/// Set data for a chart
	/// - Parameter data: array of `Double`
	/// - Returns: modified `View` with data attached
    public func data(_ data: [Double], chartValue: ChartValue? = nil) -> some View {
        let convertedData = data.map { SimpleChartDataPoint(chartPoint: $0, chartValue: "") }
        return self.data(convertedData, chartValue: chartValue)
    }

    public func data(_ data: [(String, Double)], chartValue: ChartValue? = nil) -> some View {
        let convertedData = data.map { SimpleChartDataPoint(chartPoint: $0.1, chartValue: $0.0) }
        return self.data(convertedData, chartValue: chartValue)
    }
    public func data(_ data: [ChartDataPoint], chartValue: ChartValue? = nil) -> some View {
        chartData.data = data
        return self
            .environmentObject(chartData)
            .environmentObject(ChartValue())
    }
}
