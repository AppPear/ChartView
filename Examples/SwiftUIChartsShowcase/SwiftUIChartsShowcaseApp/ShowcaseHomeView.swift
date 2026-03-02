import SwiftUI
import SwiftUICharts
import UIKit

struct ShowcaseHomeView: View {
    private let sharedBarValue = ChartValue()
    private let lineSelectionValue = ChartValue()
    @ObservedObject private var streamingSource = ChartStreamingDataSource(initialValues: [18, 23, 20, 27, 29, 24, 28, 31],
                                                                           windowSize: 8,
                                                                           autoScroll: true)
    @State private var hiddenSeries: Set<String> = []
    @State private var streamTimer: Timer?
    @State private var highContrastEnabled = false
    @State private var performanceModeEnabled = true
    @State private var callbackSelectionText = "Drag bars to receive callback events"
    private let denseSeries: [(Double, Double)] = ShowcaseHomeView.makeDenseSeries()
    private var pageBackgroundColor: Color { Color(UIColor.systemGroupedBackground) }
    private var cardBackgroundColor: Color { Color(UIColor.secondarySystemGroupedBackground) }
    private var chartSurfaceColor: Color { Color(UIColor.secondarySystemBackground) }
    private var axisColor: Color { .secondary }
    private var ringsBackgroundGradient: ColorGradient {
        ColorGradient(chartSurfaceColor, Color(UIColor.tertiarySystemBackground))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    headline
                    lineInteractionSection
                    dynamicDataSection
                    lineChartSection
                    accessibilitySection
                    axisEngineSection
                    performanceSection
                    selectionCallbackSection
                    overlayLineSection
                    legendControlSection
                    mixedChartSection
                    interactiveBarCard
                    pieAndRingsSection
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle("SwiftUICharts Showcase", displayMode: .inline)
            .background(pageBackgroundColor)
        }
        .onAppear(perform: startStreamingSimulation)
        .onDisappear(perform: stopStreamingSimulation)
    }

    private var headline: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Composable chart examples")
                .font(.title)
                .bold()
            Text("Demonstrates line, bar, pie, and rings charts with modifier-based data, style, axis, grid, and interaction APIs.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    private var lineChartSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Line Chart + Grid + Axis + Marks + Range")
                .font(.headline)

            AxisLabels {
                ChartGrid {
                    LineChart()
                        .chartLineWidth(3)
                        .chartLineBackground(ColorGradient(.blue.opacity(0.2), .clear))
                        .chartLineMarks(true, color: ColorGradient(.blue, .purple))
                        .chartLineStyle(.curved)
                        .chartLineAnimation(true)
                        .chartData([12, 34, 23, 18, 36, 22, 26])
                        .chartYRange(10...40)
                        .chartXRange(0...6)
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.blue, .purple)))
                }
                .chartGridLines(horizontal: 5, vertical: 6)
            }
            .chartXAxisLabels([(0, "M"), (1, "T"), (2, "W"), (3, "T"), (4, "F"), (5, "S"), (6, "S")], range: 0...6)
            .chartYAxisLabels([(0, "10"), (1, "20"), (2, "30"), (3, "40")], range: 0...3)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private var axisEngineSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Auto Tick Engine (Date + Collision + Rotation)")
                .font(.headline)

            AxisLabels {
                ChartGrid {
                    LineChart()
                        .chartLineWidth(3)
                        .chartLineMarks(true)
                        .chartData(weekTimeSeries)
                        .chartYRange(10...40)
                        .chartXRange(weekTimeRange)
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.green, .blue)))
                }
                .chartGridLines(horizontal: 4, vertical: 6)
            }
            .chartXAxisAutoTicks(6, format: .shortDate)
            .chartYAxisAutoTicks(4, format: .number)
            .chartXAxisLabelRotation(.degrees(-24))
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 230)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private var performanceSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Large Dataset Performance Mode")
                    .font(.headline)
                Spacer(minLength: 8)
                Toggle("Performance", isOn: $performanceModeEnabled)
                    .labelsHidden()
            }

            Text("2000 points rendered with optional downsampling + simplified line style.")
                .font(.caption)
                .foregroundColor(.secondary)

            AxisLabels {
                ChartGrid {
                    LineChart()
                        .chartData(denseSeries)
                        .chartYRange(-2...2)
                        .chartXRange(0...Double(max(0, denseSeries.count - 1)))
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.purple, .blue)))
                        .chartPerformance(performanceModeEnabled
                                          ? .automatic(threshold: 600, maxPoints: 180, simplifyLineStyle: true)
                                          : .none)
                }
                .chartGridLines(horizontal: 4, vertical: 6)
            }
            .chartXAxisAutoTicks(6, format: .number)
            .chartYAxisAutoTicks(5, format: .number)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private var accessibilitySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Accessibility + High Contrast")
                    .font(.headline)
                Spacer(minLength: 8)
                Toggle("High Contrast", isOn: $highContrastEnabled)
                    .labelsHidden()
            }

            Text("VoiceOver labels are available for bars, points, slices, and rings.")
                .font(.caption)
                .foregroundColor(.secondary)

            AxisLabels {
                ChartGrid {
                    BarChart()
                        .chartData([8, 14, 11, 17, 15, 19, 16])
                        .chartStyle(highContrastEnabled ? .highContrast : ChartStyle(backgroundColor: chartSurfaceColor,
                                                                                      foregroundColor: ColorGradient(.orange, .red)))
                }
                .chartGridLines(horizontal: 4, vertical: 0)
            }
            .chartXAxisLabels([(0, "M"), (1, "T"), (2, "W"), (3, "T"), (4, "F"), (5, "S"), (6, "S")], range: 0...6)
            .chartYAxisAutoTicks(4, format: .number)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 210)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private var selectionCallbackSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Selection Callback (No ChartValue)")
                .font(.headline)

            Text(callbackSelectionText)
                .font(.caption.monospacedDigit())
                .foregroundColor(.secondary)

            AxisLabels {
                ChartGrid {
                    BarChart()
                        .chartData([11, 17, 15, 20, 16, 14, 19])
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: [
                                                   ColorGradient(.red, .orange),
                                                   ColorGradient(.blue, .purple),
                                                   ColorGradient(.green, .yellow)
                                               ]))
                }
                .chartGridLines(horizontal: 4, vertical: 0)
            }
            .chartXAxisLabels([(0, "M"), (1, "T"), (2, "W"), (3, "T"), (4, "F"), (5, "S"), (6, "S")], range: 0...6)
            .chartYAxisAutoTicks(4, format: .number)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .chartSelectionHandler { event in
                guard event.isActive,
                      let value = event.value,
                      let index = event.index else {
                    callbackSelectionText = "No active selection"
                    return
                }

                callbackSelectionText = "Selected index \(index + 1): \(String(format: "%.1f", value))"
            }
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private var lineInteractionSection: some View {
        CardView {
            ChartLabel("Line Selection", type: .title)
            ChartLabel("Drag to inspect points", type: .legend, format: "%.1f")

            AxisLabels {
                ChartGrid {
                    LineChart()
                        .chartLineWidth(3)
                        .chartLineMarks(true, color: ColorGradient(.pink, .purple))
                        .chartLineStyle(.curved)
                        .chartData([14, 18, 12, 26, 22, 30, 24])
                        .chartYRange(10...35)
                        .chartXRange(0...6)
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.pink, .purple)))
                }
                .chartGridLines(horizontal: 5, vertical: 6)
            }
            .chartXAxisLabels([(0, "M"), (1, "T"), (2, "W"), (3, "T"), (4, "F"), (5, "S"), (6, "S")], range: 0...6)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 170)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 280)
        .padding(6)
        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                               foregroundColor: ColorGradient(.pink, .purple)))
        .chartInteractionValue(lineSelectionValue)
    }

    private var dynamicDataSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Streaming Data Source")
                    .font(.headline)
                Spacer(minLength: 8)
                Text(String(format: "%.1f", streamingSource.latestValue))
                    .font(.subheadline.monospacedDigit())
                    .foregroundColor(.secondary)
            }
            Text("First-class streaming helper with append/window/auto-scroll.")
                .font(.caption)
                .foregroundColor(.secondary)

            AxisLabels {
                ChartGrid {
                    LineChart()
                        .chartLineWidth(3)
                        .chartLineMarks(true, color: ColorGradient(.green, .blue))
                        .chartLineStyle(.curved)
                        .chartLineAnimation(true)
                        .chartData(streamingSource)
                        .chartYRange(streamingSource.suggestedYRange)
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.green, .blue)))
                }
                .chartGridLines(horizontal: 5, vertical: max(2, streamingSource.values.count))
            }
            .chartXAxisLabels(streamingSource.xLabels)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private var overlayLineSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Multiple Line Charts In One Frame")
                .font(.headline)

            AxisLabels {
                ChartGrid {
                    LineChart()
                        .chartLineMarks(true)
                        .chartLineStyle(.curved)
                        .chartData([3, 5, 4, 1, 0, 2, 4])
                        .chartYRange(0...8)
                        .chartXRange(0...6)
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.orange, .red)))

                    LineChart()
                        .chartLineMarks(true)
                        .chartLineStyle(.straight)
                        .chartLineAnimation(false)
                        .chartData([4, 1, 0, 2, 6, 3, 5])
                        .chartYRange(0...8)
                        .chartXRange(0...6)
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.green, .yellow)))
                }
                .chartGridLines(horizontal: 5, vertical: 6)
            }
            .chartXAxisLabels([(0, "1"), (1, "2"), (2, "3"), (3, "4"), (4, "5"), (5, "6"), (6, "7")], range: 0...6)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private var mixedChartSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Mixed Bar + Line Chart")
                .font(.headline)

            AxisLabels {
                ChartGrid {
                    BarChart()
                        .chartData([2, 4, 1, 3, 5])
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.orange, .red)))

                    LineChart()
                        .chartLineMarks(true)
                        .chartData([2, 4, 1, 3, 5])
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.blue, .purple)))
                }
                .chartGridLines(horizontal: 5, vertical: 5)
            }
            .chartXAxisLabels([(0, "A"), (1, "B"), (2, "C"), (3, "D"), (4, "E")], range: 0...4)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private var legendControlSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Legend + Series Visibility")
                .font(.headline)

            ChartLegend(items: [
                ChartLegendItem(id: "sales", title: "Sales", color: ColorGradient(.orange, .red)),
                ChartLegendItem(id: "forecast", title: "Forecast", color: ColorGradient(.blue, .purple))
            ], hiddenSeries: $hiddenSeries)
            .padding(.horizontal, 8)

            AxisLabels {
                ChartGrid {
                    LineChart()
                        .chartSeriesID("sales")
                        .chartLineMarks(true)
                        .chartData([2, 4, 3, 5, 4, 6, 7])
                        .chartYRange(0...8)
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.orange, .red)))

                    LineChart()
                        .chartSeriesID("forecast")
                        .chartLineMarks(true)
                        .chartData([1, 3, 4, 4, 5, 5, 6])
                        .chartYRange(0...8)
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.blue, .purple)))
                }
                .chartGridLines(horizontal: 5, vertical: 6)
            }
            .chartHiddenSeries(hiddenSeries)
            .chartXAxisLabels([(0, "Mon"), (1, "Tue"), (2, "Wed"), (3, "Thu"), (4, "Fri"), (5, "Sat"), (6, "Sun")], range: 0...6)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private var interactiveBarCard: some View {
        CardView {
            ChartLabel("Weekly Sales", type: .title)
            ChartLabel("Drag bars to inspect values", type: .legend, format: "%.0f")

            AxisLabels {
                ChartGrid {
                    BarChart()
                        .chartData([14, 22, 18, 31, 26, 19, 24])
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: [
                                                   ColorGradient(.red, .orange),
                                                   ColorGradient(.blue, .purple),
                                                   ColorGradient(.green, .yellow)
                                               ]))
                }
                .chartGridLines(horizontal: 5, vertical: 0)
            }
            .chartXAxisLabels([(0, "M"), (1, "T"), (2, "W"), (3, "T"), (4, "F"), (5, "S"), (6, "S")], range: 0...6)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 170)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 280)
        .padding(6)
        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                               foregroundColor: ColorGradient(.blue, .purple)))
        .chartInteractionValue(sharedBarValue)
    }

    private var pieAndRingsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Pie and Rings Charts")
                .font(.headline)

            HStack(spacing: 12) {
                PieChart()
                    .chartData([34, 23, 12])
                    .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                           foregroundColor: [
                                               ColorGradient(.red, .orange),
                                               ColorGradient(.blue, .purple),
                                               ColorGradient(.green, .yellow)
                                           ]))
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))

                RingsChart()
                    .chartData([25, 50, 75, 90])
                    .chartStyle(ChartStyle(backgroundColor: ringsBackgroundGradient,
                                           foregroundColor: [
                                               ColorGradient(.purple, .blue),
                                               ColorGradient(.orange, .red),
                                               ColorGradient(.green, .yellow),
                                               ColorGradient(.pink, .purple)
                                           ]))
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
            }
        }
    }

    private var weekTimeSeries: [(Double, Double)] {
        let day: TimeInterval = 24 * 60 * 60
        let start = Date(timeIntervalSince1970: 1_704_067_200).timeIntervalSince1970
        let points: [Double] = [12, 16, 21, 19, 28, 24, 31]
        return points.enumerated().map { index, value in
            (start + (Double(index) * day), value)
        }
    }

    private var weekTimeRange: ClosedRange<Double>? {
        guard let start = weekTimeSeries.first?.0, let end = weekTimeSeries.last?.0 else { return nil }
        return start...end
    }

    private static func makeDenseSeries() -> [(Double, Double)] {
        (0..<2_000).map { index in
            let x = Double(index)
            let y = sin(x / 45.0) + (cos(x / 12.0) * 0.25)
            return (x, y)
        }
    }
}

struct ShowcaseHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ShowcaseHomeView()
    }
}

private extension ShowcaseHomeView {
    func startStreamingSimulation() {
        guard streamTimer == nil else { return }

        let timer = Timer.scheduledTimer(withTimeInterval: 1.8, repeats: true) { _ in
            let current = streamingSource.latestValue
            let delta = Double.random(in: -4.5...4.5)
            let next = min(45, max(10, current + delta))
            streamingSource.append(next)
        }
        timer.tolerance = 0.35
        streamTimer = timer
    }

    func stopStreamingSimulation() {
        streamTimer?.invalidate()
        streamTimer = nil
    }
}
