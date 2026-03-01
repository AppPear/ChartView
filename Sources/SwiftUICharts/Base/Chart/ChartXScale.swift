import Foundation

struct ChartXScale {
    private let values: [Double]
    private let rangeX: ClosedRange<Double>?
    private let mode: ChartXDomainMode
    private let slotCountHint: Int

    init(values: [Double],
         rangeX: ClosedRange<Double>?,
         mode: ChartXDomainMode,
         slotCountHint: Int = 0) {
        self.values = values
        self.rangeX = rangeX
        self.mode = mode
        self.slotCountHint = slotCountHint
    }

    func normalizedX(for value: Double) -> Double {
        let normalized: Double
        switch mode {
        case .numeric:
            normalized = normalizeNumeric(value)
        case .categorical:
            normalized = normalizeCategorical(value)
        }
        return min(1.0, max(0.0, normalized))
    }

    private func normalizeNumeric(_ value: Double) -> Double {
        if let range = rangeX {
            let overreach = range.overreach
            guard overreach.isFinite, overreach > 0 else { return 0.5 }
            return (value - range.lowerBound) / overreach
        }

        guard let minValue = values.min(),
              let maxValue = values.max() else { return 0.5 }
        let span = maxValue - minValue
        guard span.isFinite, span > 0 else { return 0.5 }
        return (value - minValue) / span
    }

    private func normalizeCategorical(_ value: Double) -> Double {
        let lowerBound: Double
        if let range = rangeX {
            lowerBound = range.lowerBound
        } else {
            lowerBound = values.min() ?? 0
        }

        let slotCount: Int
        if let range = rangeX {
            let derived = Int(max(1, floor(range.overreach) + 1))
            slotCount = max(1, derived)
        } else if slotCountHint > 0 {
            slotCount = slotCountHint
        } else {
            slotCount = max(1, values.count)
        }

        return (value - lowerBound + 0.5) / Double(slotCount)
    }
}
