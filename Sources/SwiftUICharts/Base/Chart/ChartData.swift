import SwiftUI

/// Value-backed data model for chart rendering.
public struct ChartData {
    public var data: [(Double, Double)]
    public var rangeY: ClosedRange<Double>?
    public var rangeX: ClosedRange<Double>?
    public var xDomainMode: ChartXDomainMode

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
        let xScale = ChartXScale(values: values,
                                 rangeX: rangeX,
                                 mode: xDomainMode,
                                 slotCountHint: values.count)
        return values.map { xScale.normalizedX(for: $0) }
    }

    var normalisedData: [(Double, Double)] {
        Array(zip(normalisedValues, normalisedPoints))
    }

    var normalisedYRange: Double {
        rangeY == nil ? (normalisedPoints.max() ?? 0.0) - (normalisedPoints.min() ?? 0.0) : 1
    }

    var normalisedXRange: Double {
        rangeX == nil ? (normalisedValues.max() ?? 0.0) - (normalisedValues.min() ?? 0.0) : 1
    }

    var isInNegativeDomain: Bool {
        if let rangeY = rangeY {
            return rangeY.lowerBound < 0
        }

        return (points.min() ?? 0.0) < 0
    }

    public init(_ data: [Double],
                rangeY: ClosedRange<Double>? = nil,
                rangeX: ClosedRange<Double>? = nil,
                xDomainMode: ChartXDomainMode = .categorical) {
        self.data = data.enumerated().map { (index, value) in (Double(index), value) }
        self.rangeY = rangeY
        self.rangeX = rangeX
        self.xDomainMode = xDomainMode
    }

    public init(_ data: [(Double, Double)],
                rangeY: ClosedRange<Double>? = nil,
                rangeX: ClosedRange<Double>? = nil,
                xDomainMode: ChartXDomainMode = .numeric) {
        self.data = data
        self.rangeY = rangeY
        self.rangeX = rangeX
        self.xDomainMode = xDomainMode
    }

    public init(xDomainMode: ChartXDomainMode = .numeric) {
        self.data = []
        self.rangeY = nil
        self.rangeX = nil
        self.xDomainMode = xDomainMode
    }
}
