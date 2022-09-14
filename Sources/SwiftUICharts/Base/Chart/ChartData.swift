import SwiftUI

/// An observable wrapper for an array of data for use in any chart
public class ChartData: ObservableObject {
    @Published public var data: [(Double, Double)] = []
    public var rangeY: ClosedRange<Double>?
    public var rangeX: ClosedRange<Double>?

    var points: [Double] {
        data.filter { rangeX?.contains($0.0) ?? true }.map { $0.1 }
    }

    var values: [Double] {
        data.filter { rangeX?.contains($0.0) ?? true }.map { $0.0 }
    }

    var normalisedPoints: [Double] {
        let absolutePoints = points.map { abs($0) }
        var maxPoint = absolutePoints.max()
        if let rangeY = rangeY {
            maxPoint = Double(rangeY.overreach)
            return points.map { ($0 - rangeY.lowerBound) / (maxPoint ?? 1.0) }
        }

        return points.map { $0 / (maxPoint ?? 1.0) }
    }

    var normalisedValues: [Double] {
        let absoluteValues = values.map { abs($0) }
        var maxValue = absoluteValues.max()
        if let rangeX = rangeX {
            maxValue = Double(rangeX.overreach)
            return values.map { ($0 - rangeX.lowerBound) / (maxValue ?? 1.0) }
        }

        return values.map { $0 / (maxValue ?? 1.0) }
    }

    var normalisedData: [(Double, Double)] {
        Array(zip(normalisedValues, normalisedPoints))
    }

    var normalisedYRange: Double {
        if let _ = rangeY {
            return 1
        }

        return (normalisedPoints.max() ?? 0.0) - (normalisedPoints.min() ?? 0.0)
    }

    var normalisedXRange: Double {
        if let _ = rangeX {
            return 1
        }

        return (normalisedValues.max() ?? 0.0) - (normalisedValues.min() ?? 0.0)
    }

    var isInNegativeDomain: Bool {
        if let rangeY = rangeY {
            return rangeY.lowerBound < 0
        }

        return (points.min() ?? 0.0) < 0
    }

    /// Initialize with data array
    /// - Parameter data: Array of `Double`
    public init(_ data: [Double], rangeY: ClosedRange<FloatLiteralType>? = nil) {
        self.data = data.enumerated().map{ (index, value) in (Double(index), value) }
        self.rangeY = rangeY
    }

    public init(_ data: [(Double, Double)], rangeY: ClosedRange<FloatLiteralType>? = nil) {
        self.data = data
        self.rangeY = rangeY
    }

    public init() {
        self.data = []
    }
}
