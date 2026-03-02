@testable import SwiftUICharts
import SwiftUI
import XCTest

final class ChartXScaleTests: XCTestCase {

    func testCategoricalPositionsUseCenteredSlots() {
        let scale = ChartXScale(values: [0, 1, 2, 3, 4, 5, 6],
                                rangeX: nil,
                                mode: .categorical,
                                slotCountHint: 7)

        let expected: [Double] = [1, 3, 5, 7, 9, 11, 13].map { $0 / 14.0 }
        let actual = (0...6).map { scale.normalizedX(for: Double($0)) }

        for (a, e) in zip(actual, expected) {
            XCTAssertEqual(a, e, accuracy: 0.0001)
        }
    }

    func testNumericPositionsUseEdgeMappingWithinRange() {
        let scale = ChartXScale(values: [10, 20, 30], rangeX: 10...30, mode: .numeric)

        XCTAssertEqual(scale.normalizedX(for: 10), 0, accuracy: 0.0001)
        XCTAssertEqual(scale.normalizedX(for: 20), 0.5, accuracy: 0.0001)
        XCTAssertEqual(scale.normalizedX(for: 30), 1, accuracy: 0.0001)
    }

    func testSingleCategoricalValueCentersAtHalf() {
        let scale = ChartXScale(values: [0], rangeX: nil, mode: .categorical, slotCountHint: 1)
        XCTAssertEqual(scale.normalizedX(for: 0), 0.5, accuracy: 0.0001)
    }

    func testNormalizedXIsClamped() {
        let scale = ChartXScale(values: [10, 20, 30], rangeX: 10...30, mode: .numeric)
        XCTAssertEqual(scale.normalizedX(for: -100), 0, accuracy: 0.0001)
        XCTAssertEqual(scale.normalizedX(for: 100), 1, accuracy: 0.0001)
    }
}

final class ChartDataXNormalizationTests: XCTestCase {

    func testArrayDataUsesCategoricalCenterMapping() {
        let data = ChartData([10, 20, 30], xDomainMode: .categorical)
        let expected = [1.0 / 6.0, 3.0 / 6.0, 5.0 / 6.0]

        for (a, e) in zip(data.normalisedValues, expected) {
            XCTAssertEqual(a, e, accuracy: 0.0001)
        }
    }

    func testArrayDataWithRangeRemainsCenteredWithinVisibleSlots() {
        let data = ChartData([11, 12, 13], rangeX: 1...2, xDomainMode: .categorical)
        XCTAssertEqual(data.normalisedValues.count, 2)
        XCTAssertEqual(data.normalisedValues[0], 0.25, accuracy: 0.0001)
        XCTAssertEqual(data.normalisedValues[1], 0.75, accuracy: 0.0001)
    }

    func testTupleDataUsesNumericMapping() {
        let data = ChartData([(10, 1), (20, 2), (30, 3)], rangeX: 10...30, xDomainMode: .numeric)
        XCTAssertEqual(data.normalisedValues[0], 0, accuracy: 0.0001)
        XCTAssertEqual(data.normalisedValues[1], 0.5, accuracy: 0.0001)
        XCTAssertEqual(data.normalisedValues[2], 1, accuracy: 0.0001)
    }
}

final class ChartAxisLabelMapperTests: XCTestCase {

    func testStringLabelsMapToIndexedAnchors() {
        let mapped = ChartAxisLabelMapper.mapXAxis(["A", "B", "C"])
        XCTAssertEqual(mapped, [
            ChartXAxisLabel(value: 0, title: "A"),
            ChartXAxisLabel(value: 1, title: "B"),
            ChartXAxisLabel(value: 2, title: "C")
        ])
    }

    func testTupleLabelsPreserveValuesAndFillMissingRangeEntries() {
        let mapped = ChartAxisLabelMapper.mapXAxis([(1, "A"), (2.5, "B2"), (3, "C")], in: 1...3)
        XCTAssertEqual(mapped, [
            ChartXAxisLabel(value: 1, title: "A"),
            ChartXAxisLabel(value: 2, title: ""),
            ChartXAxisLabel(value: 2.5, title: "B2"),
            ChartXAxisLabel(value: 3, title: "C")
        ])
    }
}
