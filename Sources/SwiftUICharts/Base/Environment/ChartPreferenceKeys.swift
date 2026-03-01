import SwiftUI

struct ChartDataPointsSnapshot: Equatable {
    let points: [(Double, Double)]

    static func == (lhs: ChartDataPointsSnapshot, rhs: ChartDataPointsSnapshot) -> Bool {
        guard lhs.points.count == rhs.points.count else { return false }
        return zip(lhs.points, rhs.points).allSatisfy { lhsPoint, rhsPoint in
            lhsPoint.0 == rhsPoint.0 && lhsPoint.1 == rhsPoint.1
        }
    }
}

struct ChartDataPointsPreferenceKey: PreferenceKey {
    static var defaultValue: ChartDataPointsSnapshot = ChartDataPointsSnapshot(points: [])

    static func reduce(value: inout ChartDataPointsSnapshot, nextValue: () -> ChartDataPointsSnapshot) {
        let next = nextValue()
        if next.points.count >= value.points.count {
            value = next
        }
    }
}

struct ChartXRangePreferenceKey: PreferenceKey {
    static var defaultValue: ClosedRange<Double>? = nil

    static func reduce(value: inout ClosedRange<Double>?, nextValue: () -> ClosedRange<Double>?) {
        if let next = nextValue() {
            value = next
        }
    }
}

struct ChartXDomainModePreferenceKey: PreferenceKey {
    static var defaultValue: ChartXDomainMode = .numeric

    static func reduce(value: inout ChartXDomainMode, nextValue: () -> ChartXDomainMode) {
        let next = nextValue()
        if value == .categorical || next == .categorical {
            value = .categorical
        } else {
            value = .numeric
        }
    }
}
