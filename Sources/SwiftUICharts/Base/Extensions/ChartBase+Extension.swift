import SwiftUI

extension ChartBase {
    public func data(_ data: [Double]) -> some ChartBase {
        chartData.data = data.enumerated().map{ (index, value) in (Double(index), value) }
        return self
    }

    public func data(_ data: [(Double, Double)]) -> some ChartBase {
        chartData.data = data
        return self
    }

    public func rangeY(_ range: ClosedRange<FloatLiteralType>) -> some ChartBase{
        chartData.rangeY = range
        return self
    }

    public func rangeX(_ range: ClosedRange<FloatLiteralType>) -> some ChartBase{
        chartData.rangeX = range
        return self
    }
}
