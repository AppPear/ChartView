import SwiftUI

private struct ChartDataValuesModifier: ViewModifier {
    let points: [(Double, Double)]
    let xDomainMode: ChartXDomainMode

    func body(content: Content) -> some View {
        content
            .environment(\.chartDataPoints, points)
            .environment(\.chartXDomainMode, xDomainMode)
            .preference(key: ChartDataPointsPreferenceKey.self, value: ChartDataPointsSnapshot(points: points))
            .preference(key: ChartXDomainModePreferenceKey.self, value: xDomainMode)
    }
}

private struct ChartXRangeModifier: ViewModifier {
    let range: ClosedRange<Double>?

    func body(content: Content) -> some View {
        content
            .environment(\.chartXRange, range)
            .preference(key: ChartXRangePreferenceKey.self, value: range)
    }
}

private struct ChartYRangeModifier: ViewModifier {
    let range: ClosedRange<Double>?

    func body(content: Content) -> some View {
        content.environment(\.chartYRange, range)
    }
}

public extension View {
    func chartData(_ stream: ChartStreamingDataSource) -> some View {
        chartData(stream.values)
    }

    func chartData(_ points: [Double]) -> some View {
        let indexed = points.enumerated().map { (index, value) in (Double(index), value) }
        return modifier(ChartDataValuesModifier(points: indexed, xDomainMode: .categorical))
    }

    func chartData(_ points: [(Double, Double)]) -> some View {
        modifier(ChartDataValuesModifier(points: points, xDomainMode: .numeric))
    }

    func chartXRange(_ range: ClosedRange<Double>?) -> some View {
        modifier(ChartXRangeModifier(range: range))
    }

    func chartYRange(_ range: ClosedRange<Double>?) -> some View {
        modifier(ChartYRangeModifier(range: range))
    }
}
