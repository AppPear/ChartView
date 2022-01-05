import SwiftUI

/// An observable wrapper for an array of data for use in any chart
public class ChartData<Root: ChartDataPoint>: ObservableObject {
    @Published public var data: [Root] = []
    @Published public var keyPath: KeyPath<Root, Double>
    
    var points: [Double] {
        data.map { $0[keyPath: keyPath] }
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

    
    
    
    public init4(_ data: [Root], keyPath: KeyPath<Root, Double>) {
        self.data = data
        self.keyPath = \.chartPoint
    }

    public init() {
        self.data = []
    }
}

extension ChartData where Root == SimpleChartDataPoint {
    /// Initialize with data array
    /// - Parameter data: Array of `Double`
    public convenience init(_ data: [Double]) {
        self.data = data.map { SimpleChartDataPoint(chartPoint: $0, chartValue: "") }
    }

    public convenience init(_ data: [(String, Double)]) {
        self.data = data.map { SimpleChartDataPoint(chartPoint: $0.1, chartValue: $0.0) }
        self.keyPath = \.chartPoint
    }
}
