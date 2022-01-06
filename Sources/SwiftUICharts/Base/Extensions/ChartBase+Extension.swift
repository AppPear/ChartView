import SwiftUI

extension View where Self: ChartBase {
	
    public func data<ChartValueType: ChartValue>(_ data: [Root], keyPathForGraphValue: KeyPath<Root, Double>, chartValue: ChartValueType) -> some View where ChartValueType.Root == Root {
        chartData.data = data
        chartData.keyPathForGraphValue = keyPathForGraphValue
        
        return self
            .environmentObject(chartData)
            .environmentObject(chartValue)
        
    }
    
    
}

extension View where Self: ChartBase, ChartValueType == SimpleChartValue {
    public func data(_ data: [Double]) -> some View {
        let convertedData = data.map { SimpleChartDataPoint(chartPoint: $0, chartValue: "") }
        return self.data(convertedData, keyPathForGraphValue: \.chartPoint)
    }

    public func data(_ data: [(String, Double)]) -> some View {
        let convertedData = data.map { SimpleChartDataPoint(chartPoint: $0.1, chartValue: $0.0) }
        return self.data(convertedData, keyPathForGraphValue: \.chartPoint)
    }
    public func data(_ data: [Root], keyPathForGraphValue: KeyPath<Root, Double>) -> some View where ChartValueType.Root == Root {
        chartData.data = data
        chartData.keyPathForGraphValue = keyPathForGraphValue
        
        return self
            .environmentObject(chartData)
            .environmentObject(SimpleChartValue())
        
    }
}
