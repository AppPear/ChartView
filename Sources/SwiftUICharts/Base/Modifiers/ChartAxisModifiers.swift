import SwiftUI

private struct ChartXAxisLabelsModifier: ViewModifier {
    @Environment(\.chartAxisConfig) private var currentConfig

    let labels: [ChartXAxisLabel]
    let range: ClosedRange<Double>?
    let mode: ChartXDomainMode

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.axisXLabels = labels
        updated.axisXRange = range
        updated.axisXDomainMode = mode
        return content.environment(\.chartAxisConfig, updated)
    }
}

private struct ChartYAxisLabelsModifier: ViewModifier {
    @Environment(\.chartAxisConfig) private var currentConfig

    let labels: [String]
    let position: AxisLabelsYPosition

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.axisYLabels = labels
        updated.axisLabelsYPosition = position
        return content.environment(\.chartAxisConfig, updated)
    }
}

private struct ChartAxisFontModifier: ViewModifier {
    @Environment(\.chartAxisConfig) private var currentConfig

    let font: Font

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.axisFont = font
        return content.environment(\.chartAxisConfig, updated)
    }
}

private struct ChartAxisColorModifier: ViewModifier {
    @Environment(\.chartAxisConfig) private var currentConfig

    let color: Color

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.axisFontColor = color
        return content.environment(\.chartAxisConfig, updated)
    }
}

public extension View {
    func chartXAxisLabels(_ labels: [String]) -> some View {
        modifier(ChartXAxisLabelsModifier(labels: ChartAxisLabelMapper.mapXAxis(labels),
                                         range: labels.isEmpty ? nil : 0...Double(labels.count - 1),
                                         mode: .categorical))
    }

    func chartXAxisLabels(_ labels: [(Double, String)], range: ClosedRange<Int>) -> some View {
        let mapped = ChartAxisLabelMapper.mapXAxis(labels, in: range)
        return modifier(ChartXAxisLabelsModifier(labels: mapped,
                                                 range: Double(range.lowerBound)...Double(range.upperBound),
                                                 mode: .numeric))
    }

    func chartYAxisLabels(_ labels: [String],
                          position: AxisLabelsYPosition = .leading) -> some View {
        modifier(ChartYAxisLabelsModifier(labels: labels, position: position))
    }

    func chartYAxisLabels(_ labels: [(Double, String)],
                          range: ClosedRange<Int>,
                          position: AxisLabelsYPosition = .leading) -> some View {
        modifier(ChartYAxisLabelsModifier(labels: ChartAxisLabelMapper.mapYAxis(labels, in: range), position: position))
    }

    func chartAxisFont(_ font: Font) -> some View {
        modifier(ChartAxisFontModifier(font: font))
    }

    func chartAxisColor(_ color: Color) -> some View {
        modifier(ChartAxisColorModifier(color: color))
    }
}

enum ChartAxisLabelMapper {
    static func mapXAxis(_ labels: [String]) -> [ChartXAxisLabel] {
        labels.enumerated().map { index, label in
            ChartXAxisLabel(value: Double(index), title: label)
        }
    }

    static func mapXAxis(_ labels: [(Double, String)], in range: ClosedRange<Int>) -> [ChartXAxisLabel] {
        var labelsByValue: [Double: String] = [:]
        for (value, title) in labels {
            labelsByValue[value] = title
        }

        for value in range {
            labelsByValue[Double(value)] = labelsByValue[Double(value)] ?? ""
        }

        return labelsByValue
            .sorted(by: { $0.key < $1.key })
            .map { ChartXAxisLabel(value: $0.key, title: $0.value) }
    }

    static func mapYAxis(_ labels: [(Double, String)], in range: ClosedRange<Int>) -> [String] {
        let count = max(0, range.overreach + 1)
        guard count > 0 else { return [] }

        var labelArray = Array(repeating: "", count: count)
        for (value, label) in labels {
            let index = Int(value) - range.lowerBound
            if index >= 0, index < labelArray.count {
                labelArray[index] = label
            }
        }
        return labelArray
    }
}
