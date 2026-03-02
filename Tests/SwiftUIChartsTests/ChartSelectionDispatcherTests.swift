@testable import SwiftUICharts
import XCTest

final class ChartSelectionDispatcherTests: XCTestCase {

    func testPublishUpdatesChartValueAndEmitsCallback() {
        let chartValue = ChartValue()
        var received: ChartSelectionEvent?

        ChartSelectionDispatcher.publish(chartValue: chartValue,
                                         handler: { event in
                                             received = event
                                         },
                                         value: 42,
                                         index: 3,
                                         isActive: true)

        XCTAssertTrue(chartValue.interactionInProgress)
        XCTAssertEqual(chartValue.currentValue, 42)
        XCTAssertEqual(received?.value, 42)
        XCTAssertEqual(received?.index, 3)
        XCTAssertEqual(received?.isActive, true)
    }

    func testPublishInactiveClearsInteractionState() {
        let chartValue = ChartValue()
        chartValue.currentValue = 10
        chartValue.interactionInProgress = true
        var received: ChartSelectionEvent?

        ChartSelectionDispatcher.publish(chartValue: chartValue,
                                         handler: { event in
                                             received = event
                                         },
                                         value: nil,
                                         index: nil,
                                         isActive: false)

        XCTAssertFalse(chartValue.interactionInProgress)
        XCTAssertEqual(chartValue.currentValue, 10)
        XCTAssertNil(received?.value)
        XCTAssertNil(received?.index)
        XCTAssertEqual(received?.isActive, false)
    }
}
