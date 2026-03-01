import SwiftUI
import SwiftUICharts
import UIKit

struct ShowcaseHomeView: View {
    private let sharedBarValue = ChartValue()
    private let lineSelectionValue = ChartValue()
    @ObservedObject private var liveFeed = MockLiveChartFeed()
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
                    overlayLineSection
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
                Text("Live Dynamic Data Source (Mock)")
                    .font(.headline)
                Spacer(minLength: 8)
                Text(String(format: "%.1f", liveFeed.latestValue))
                    .font(.subheadline.monospacedDigit())
                    .foregroundColor(.secondary)
            }
            Text("Updates every few seconds with simulated network delay.")
                .font(.caption)
                .foregroundColor(.secondary)

            AxisLabels {
                ChartGrid {
                    LineChart()
                        .chartLineWidth(3)
                        .chartLineMarks(true, color: ColorGradient(.green, .blue))
                        .chartLineStyle(.curved)
                        .chartLineAnimation(true)
                        .chartData(liveFeed.points)
                        .chartYRange(liveFeed.yRange)
                        .chartXRange(0...Double(max(0, liveFeed.points.count - 1)))
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.green, .blue)))
                }
                .chartGridLines(horizontal: 5, vertical: max(2, liveFeed.points.count))
            }
            .chartXAxisLabels(liveFeed.xLabels)
            .chartAxisColor(axisColor)
            .chartAxisFont(.caption)
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
        .onAppear {
            liveFeed.start()
        }
        .onDisappear {
            liveFeed.stop()
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
}

struct ShowcaseHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ShowcaseHomeView()
    }
}

final class MockLiveChartFeed: ObservableObject {
    @Published private(set) var points: [Double] = [18, 23, 20, 27, 29, 24, 28, 31]
    @Published private(set) var latestValue: Double = 31

    private var timer: Timer?

    var xLabels: [String] {
        (1...points.count).map(String.init)
    }

    var yRange: ClosedRange<Double> {
        let minValue = points.min() ?? 0
        let maxValue = points.max() ?? 10
        let lower = max(0, floor(minValue / 5) * 5 - 5)
        let upper = max(lower + 10, ceil(maxValue / 5) * 5 + 5)
        return lower...upper
    }

    func start() {
        guard timer == nil else { return }
        let liveTimer = Timer.scheduledTimer(withTimeInterval: 2.2, repeats: true) { [weak self] _ in
            self?.simulateFetch()
        }
        liveTimer.tolerance = 0.4
        timer = liveTimer
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        stop()
    }

    private func simulateFetch() {
        let current = points.last ?? 25
        let delay = Double.random(in: 0.15...0.7)

        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            let delta = Double.random(in: -4.5...4.5)
            let nextValue = min(45, max(10, current + delta))

            DispatchQueue.main.async {
                self.push(nextValue)
            }
        }
    }

    private func push(_ value: Double) {
        guard !points.isEmpty else {
            points = [value]
            latestValue = value
            return
        }

        points.removeFirst()
        points.append(value)
        latestValue = value
    }
}
