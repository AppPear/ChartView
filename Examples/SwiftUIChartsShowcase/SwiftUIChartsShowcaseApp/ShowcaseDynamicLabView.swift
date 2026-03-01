import SwiftUI
import SwiftUICharts
import UIKit

struct ShowcaseDynamicLabView: View {
    @ObservedObject private var stream = ChartStreamingDataSource(initialValues: [28, 31, 30, 35, 33, 36, 34, 37],
                                                                  windowSize: 8,
                                                                  autoScroll: true)
    @State private var timer: Timer?
    @State private var callbackText = "Touch bars to receive callback events."

    private var pageBackgroundColor: Color { Color(UIColor.systemGroupedBackground) }
    private var cardBackgroundColor: Color { Color(UIColor.secondarySystemGroupedBackground) }
    private var chartSurfaceColor: Color { Color(UIColor.secondarySystemBackground) }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    liveStreamSection
                    callbackSection
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle("Dynamic Data Lab", displayMode: .inline)
            .background(pageBackgroundColor)
        }
        .onAppear(perform: startFeed)
        .onDisappear(perform: stopFeed)
    }

    private var liveStreamSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Streaming Feed (Mock Dynamic)")
                .font(.headline)
            Text("A timer appends points continuously to emulate live network updates.")
                .font(.caption)
                .foregroundColor(.secondary)

            AxisLabels {
                ChartGrid {
                    LineChart()
                        .chartData(stream)
                        .chartYRange(stream.suggestedYRange)
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: ColorGradient(.green, .blue)))
                        .chartLineMarks(true, color: ColorGradient(.green, .blue))
                }
                .chartGridLines(horizontal: 5, vertical: max(2, stream.values.count))
            }
            .chartXAxisLabels(stream.xLabels)
            .chartYAxisAutoTicks(5, format: .number)
            .chartAxisFont(.caption)
            .chartAxisColor(.secondary)
            .frame(height: 240)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private var callbackSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Selection Callback Output")
                .font(.headline)
            Text(callbackText)
                .font(.caption.monospacedDigit())
                .foregroundColor(.secondary)

            AxisLabels {
                ChartGrid {
                    BarChart()
                        .chartData(stream.values)
                        .chartStyle(ChartStyle(backgroundColor: chartSurfaceColor,
                                               foregroundColor: [
                                                   ColorGradient(.orange, .red),
                                                   ColorGradient(.blue, .purple),
                                                   ColorGradient(.green, .yellow)
                                               ]))
                }
                .chartGridLines(horizontal: 4, vertical: 0)
            }
            .chartXAxisLabels(stream.xLabels)
            .chartYAxisAutoTicks(4, format: .number)
            .chartAxisFont(.caption)
            .chartAxisColor(.secondary)
            .chartSelectionHandler { event in
                guard event.isActive,
                      let value = event.value,
                      let index = event.index else {
                    callbackText = "No active selection"
                    return
                }

                callbackText = "Slot \(index + 1): \(String(format: "%.2f", value))"
            }
            .frame(height: 230)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 14).fill(cardBackgroundColor))
        }
    }

    private func startFeed() {
        guard timer == nil else { return }

        let next = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            let drift = Double.random(in: -2.0...2.0)
            let value = min(45, max(20, stream.latestValue + drift))
            stream.append(value)
        }
        next.tolerance = 0.25
        timer = next
    }

    private func stopFeed() {
        timer?.invalidate()
        timer = nil
    }
}

struct ShowcaseDynamicLabView_Previews: PreviewProvider {
    static var previews: some View {
        ShowcaseDynamicLabView()
    }
}
