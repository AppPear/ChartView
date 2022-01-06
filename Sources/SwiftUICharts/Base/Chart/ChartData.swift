import SwiftUI

/// An observable wrapper for an array of data for use in any chart
public class ChartData<Root: ChartDataPoint>: ObservableObject {
    @Published public var data: [Root] = []
    @Published public var keyPathForGraphValue: KeyPath<Root, Double>
    
    var points: [Double] {
        var d = data.map {
            $0[keyPath: keyPathForGraphValue]
        }
        //CoreGraphics won't draw without this if all vals are 0
        let notZeros = d.filter({ val in
            val != 0.0
        })
        if notZeros.isEmpty {
            d = d.map({ val in
                return 0.01
            })
        }
        return d
    }

    var values: [String] {
        data.map { $0.chartValue }
    }

    var normalisedPoints: [Double] {
        let absolutePoints = points.map { abs($0) }
        var absMax = absolutePoints.max()
        //CoreGraphics won't draw without this if all vals are 0
        if absMax == 0.0 {
            absMax = 1.0
        }
        let vals = points.map { $0 / (absolutePoints.max() ?? 1.0) }
        return vals
    }

    var normalisedRange: Double {
        //CoreGraphics won't draw without this if all vals are 0
        var range = (normalisedPoints.max() ?? 0.0) - (normalisedPoints.min() ?? 0.0)
        if range == 0 {
            range = 1.0
        }
        return range
    }

    var isInNegativeDomain: Bool {
        (points.min() ?? 0.0) < 0
    }

    
    
    
    public init(_ data: [Root], keyPathForGraphValue: KeyPath<Root, Double>)  {
        self.keyPathForGraphValue = keyPathForGraphValue
        self.data = data
        
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
    
    public convenience init() {
        self.init([], keyPathForGraphValue: \.chartPoint)
        
    }
}
