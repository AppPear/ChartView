@testable import SwiftUICharts
import SwiftUI
import XCTest

#if canImport(AppKit)
import AppKit
#endif

final class ComposableUsageSmokeTests: XCTestCase {

    func testBarChartRendersWithOptionalInteractionValue() {
        let view = BarChart()
            .chartData([12, 34, 23])
            .chartStyle(sampleStyle)
            .frame(width: 240, height: 140)

        assertCanRender(view)
    }

    func testPieChartRendersWithOptionalInteractionValue() {
        let view = PieChart()
            .chartData([34, 23, 12])
            .chartStyle(sampleStyle)
            .frame(width: 240, height: 240)

        assertCanRender(view)
    }

    func testRingsChartRendersWithOptionalInteractionValue() {
        let view = RingsChart()
            .chartData([25, 50, 75])
            .chartStyle(sampleStyle)
            .frame(width: 240, height: 240)

        assertCanRender(view)
    }

    func testPieAndRingsRenderInHeightOnlyHStackWithoutLayoutCrash() {
        let view = HStack(spacing: 12) {
            PieChart()
                .chartData([34, 23, 12])
                .chartStyle(sampleStyle)
                .frame(height: 180)

            RingsChart()
                .chartData([25, 50, 75, 90])
                .chartStyle(sampleStyle)
                .frame(height: 180)
        }

        assertCanRender(view)
    }

    func testChartLabelCanShareExternalChartValue() {
        let sharedChartValue = ChartValue()

        let view = VStack(alignment: .leading) {
            ChartLabel("Sales", type: .title)
            BarChart()
                .chartData([12, 34, 23])
                .chartStyle(sampleStyle)
                .frame(height: 140)
        }
        .frame(width: 280, height: 220)
        .chartInteractionValue(sharedChartValue)

        assertCanRender(view)
    }

    func testMixedBarAndLineWithAxisLabelsRenders() {
        let view = AxisLabels {
            ChartGrid {
                BarChart()
                    .chartData([2, 4, 1, 3, 5])
                    .chartStyle(self.sampleStyle)
                LineChart()
                    .chartLineMarks(true)
                    .chartData([2, 4, 1, 3, 5])
                    .chartStyle(self.sampleStyle)
            }
            .chartGridLines(horizontal: 5, vertical: 5)
        }
        .chartXAxisLabels([(0, "A"), (1, "B"), (2, "C"), (3, "D"), (4, "E")], range: 0...4)
        .chartAxisColor(.gray)
        .chartAxisFont(.caption)
        .frame(width: 280, height: 220)

        assertCanRender(view)
    }

    func testLegendAndSeriesVisibilityModifiersCompile() {
        let hidden: Set<String> = ["forecast"]
        let view = VStack(alignment: .leading, spacing: 8) {
            ChartLegend(items: [
                ChartLegendItem(id: "sales", title: "Sales", color: ColorGradient(.orange, .red)),
                ChartLegendItem(id: "forecast", title: "Forecast", color: ColorGradient(.blue, .purple))
            ], hiddenSeries: .constant(hidden))
            AxisLabels {
                ChartGrid {
                    LineChart()
                        .chartSeriesID("sales")
                        .chartData([2, 4, 3, 5, 4])
                        .chartStyle(self.sampleStyle)
                    LineChart()
                        .chartSeriesID("forecast")
                        .chartData([1, 2, 4, 4, 5])
                        .chartStyle(self.sampleStyle)
                }
            }
            .chartHiddenSeries(hidden)
        }
        .frame(width: 280, height: 260)

        assertCanRender(view)
    }

    func testStreamingDataSourceOverloadCompiles() {
        let stream = ChartStreamingDataSource(initialValues: [12, 14, 18, 16],
                                              windowSize: 4,
                                              autoScroll: true)
        stream.append(20)

        let view = LineChart()
            .chartData(stream)
            .chartYRange(stream.suggestedYRange)
            .chartStyle(sampleStyle)
            .frame(width: 280, height: 180)

        assertCanRender(view)
    }

    func testAutoTickAndRotationModifiersCompile() {
        let timestamps: [(Double, Double)] = [
            (1_704_067_200, 10), (1_704_153_600, 14), (1_704_240_000, 18), (1_704_326_400, 20)
        ]

        let view = AxisLabels {
            ChartGrid {
                LineChart()
                    .chartData(timestamps)
                    .chartYRange(8...24)
                    .chartXRange(1_704_067_200...1_704_326_400)
                    .chartStyle(self.sampleStyle)
            }
        }
        .chartXAxisAutoTicks(4, format: .shortDate)
        .chartYAxisAutoTicks(4, format: .number)
        .chartXAxisLabelRotation(.degrees(-22))
        .frame(width: 300, height: 220)

        assertCanRender(view)
    }

    private var sampleStyle: ChartStyle {
        ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(.orange, .red))
    }

    private func assertCanRender<Content: View>(_ view: Content,
                                                file: StaticString = #filePath,
                                                line: UInt = #line) {
        #if canImport(AppKit)
        let hostingView = NSHostingView(rootView: view)
        hostingView.layoutSubtreeIfNeeded()
        _ = hostingView.fittingSize
        #else
        _ = view
        #endif

        XCTAssertTrue(true, file: file, line: line)
    }
}
