import SwiftUI

extension View where Self: AdvancedChartBase {
	
    public func data<Root: ChartDataPoint, ChartValueType: ChartValue>(_ data: ChartData<Root>, chartValue: ChartValueType) -> some View where ChartValueType.Root == Root {
        
        return self
            .environmentObject(data)
            .environmentObject(chartValue)
        
    }
    
    
}

extension View where Self: ChartBase, Root == SimpleChartDataPoint {
    public func data(_ data: [Double]) -> some View {
        let convertedData = data.map { SimpleChartDataPoint(chartPoint: $0, chartValue: "") }
        return self.data(convertedData, keyPathForGraphValue: \Root.chartPoint)
    }

    public func data(_ data: [(String, Double)]) -> some View {
        let convertedData = data.map { SimpleChartDataPoint(chartPoint: $0.1, chartValue: $0.0) }
        return self.data(convertedData, keyPathForGraphValue: \Root.chartPoint)
    }
    public func data(_ data: [Root], keyPathForGraphValue: KeyPath<Root, Double>) -> some View where ChartValueType.Root == Root {
        chartData.data = data
        chartData.keyPathForGraphValue = keyPathForGraphValue
        
        return self
            .environmentObject(chartData)
            .environmentObject(SimpleChartValue())
        
    }
}
