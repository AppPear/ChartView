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
        updated.axisXAutoTickCount = nil
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
        updated.axisYAutoTickCount = nil
        return content.environment(\.chartAxisConfig, updated)
    }
}

private struct ChartXAxisAutoTicksModifier: ViewModifier {
    @Environment(\.chartAxisConfig) private var currentConfig

    let count: Int
    let format: ChartAxisTickFormat

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.axisXAutoTickCount = max(2, count)
        updated.axisXTickFormat = format
        updated.axisXLabels = []
        return content.environment(\.chartAxisConfig, updated)
    }
}

private struct ChartYAxisAutoTicksModifier: ViewModifier {
    @Environment(\.chartAxisConfig) private var currentConfig

    let count: Int
    let format: ChartAxisTickFormat
    let position: AxisLabelsYPosition

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.axisYAutoTickCount = max(2, count)
        updated.axisYTickFormat = format
        updated.axisYLabels = []
        updated.axisLabelsYPosition = position
        return content.environment(\.chartAxisConfig, updated)
    }
}

private struct ChartXAxisLabelRotationModifier: ViewModifier {
    @Environment(\.chartAxisConfig) private var currentConfig

    let angle: Angle

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.axisXLabelRotation = angle
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

    func chartXAxisAutoTicks(_ count: Int = 5,
                             format: ChartAxisTickFormat = .number) -> some View {
        modifier(ChartXAxisAutoTicksModifier(count: count, format: format))
    }

    func chartYAxisAutoTicks(_ count: Int = 5,
                             format: ChartAxisTickFormat = .number,
                             position: AxisLabelsYPosition = .leading) -> some View {
        modifier(ChartYAxisAutoTicksModifier(count: count,
                                             format: format,
                                             position: position))
    }

    func chartXAxisLabelRotation(_ angle: Angle) -> some View {
        modifier(ChartXAxisLabelRotationModifier(angle: angle))
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
