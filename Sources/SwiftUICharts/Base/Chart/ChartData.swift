import SwiftUI

/// An observable wrapper for an array of data for use in any chart
public class ChartData<Root: ChartDataPoint>: ObservableObject {
    @Published public var data: [Root] = []
    @Published public var keyPathForGraphValue: KeyPath<Root, Double>
    
    var points: [Double] {
        data.map { $0[keyPath: keyPathForGraphValue] }
    }

    var values: [String] {
        data.map { $0.chartValue }
    }

    var normalisedPoints: [Double] {
        let absolutePoints = points.map { abs($0) }
        return points.map { $0 / (absolutePoints.max() ?? 1.0) }
    }

    var normalisedRange: Double {
        (normalisedPoints.max() ?? 0.0) - (normalisedPoints.min() ?? 0.0)
    }

    var isInNegativeDomain: Bool {
        (points.min() ?? 0.0) < 0
    }

    
    
    
    public init(_ data: [Root], keyPathForGraphValue: KeyPath<Root, Double>) {
        self.data = data
        self.keyPathForGraphValue = \.chartPoint
    }

    public convenience init() {
        self.init([], keyPathForGraphValue: \.chartPoint)
        
    }
}

extension ChartData where Root == SimpleChartDataPoint {
    /// Initialize with data array
    /// - Parameter data: Array of `Double`
    public convenience init(_ data: [Double]) {
        self.init(data.map { SimpleChartDataPoint(chartPoint: $0, chartValue: "") },
                  keyPathForGraphValue: \.chartPoint)
    }

    public convenience init(_ data: [(String, Double)]) {
        self.init(data.map { SimpleChartDataPoint(chartPoint: $0.1, chartValue: $0.0) },
                  keyPathForGraphValue: \.chartPoint)
    }
    
}
