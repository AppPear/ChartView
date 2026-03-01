import Foundation

public final class ChartStreamingDataSource: ObservableObject {
    @Published public private(set) var values: [Double]

    public var windowSize: Int
    public var autoScroll: Bool

    private var startingIndex: Int

    public var latestValue: Double {
        values.last ?? 0
    }

    public var xLabels: [String] {
        guard !values.isEmpty else { return [] }
        return (startingIndex..<(startingIndex + values.count)).map(String.init)
    }

    public var suggestedYRange: ClosedRange<Double> {
        let minValue = values.min() ?? 0
        let maxValue = values.max() ?? 1
        let span = max(1, maxValue - minValue)
        let padding = max(1, span * 0.15)
        return (minValue - padding)...(maxValue + padding)
    }

    public init(initialValues: [Double] = [],
                windowSize: Int = 20,
                autoScroll: Bool = true,
                startingIndex: Int = 1) {
        self.values = initialValues
        self.windowSize = max(1, windowSize)
        self.autoScroll = autoScroll
        self.startingIndex = max(0, startingIndex)
        normalizeWindow()
    }

    public func append(_ value: Double) {
        values.append(value)
        normalizeWindow()
    }

    public func append(contentsOf newValues: [Double]) {
        values.append(contentsOf: newValues)
        normalizeWindow()
    }

    public func reset(_ newValues: [Double], startingIndex: Int = 1) {
        values = newValues
        self.startingIndex = max(0, startingIndex)
        normalizeWindow()
    }

    private func normalizeWindow() {
        guard autoScroll else { return }

        let overflow = max(0, values.count - windowSize)
        if overflow > 0 {
            values.removeFirst(overflow)
            startingIndex += overflow
        }
    }
}
