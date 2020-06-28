import SwiftUI

extension View where Self: ChartBase {
    public func data(_ data: [Double]) -> some View {
        chartData.data = data
        return self
            .environmentObject(chartData)
            .environmentObject(ChartValue())
    }
}
