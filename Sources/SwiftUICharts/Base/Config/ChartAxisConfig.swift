import SwiftUI

public enum ChartAxisTickFormat {
    case number
    case shortDate
}

public struct ChartXAxisLabel: Equatable {
    public let value: Double
    public let title: String

    public init(value: Double, title: String) {
        self.value = value
        self.title = title
    }
}

public struct ChartAxisConfig {
    public var axisYLabels: [String]
    public var axisXLabels: [ChartXAxisLabel]
    public var axisXRange: ClosedRange<Double>?
    public var axisXDomainMode: ChartXDomainMode
    public var axisXAutoTickCount: Int?
    public var axisYAutoTickCount: Int?
    public var axisXTickFormat: ChartAxisTickFormat
    public var axisYTickFormat: ChartAxisTickFormat
    public var axisXLabelRotation: Angle
    public var axisFont: Font
    public var axisFontColor: Color
    public var axisLabelsYPosition: AxisLabelsYPosition

    public init(axisYLabels: [String] = [],
                axisXLabels: [ChartXAxisLabel] = [],
                axisXRange: ClosedRange<Double>? = nil,
                axisXDomainMode: ChartXDomainMode = .categorical,
                axisXAutoTickCount: Int? = nil,
                axisYAutoTickCount: Int? = nil,
                axisXTickFormat: ChartAxisTickFormat = .number,
                axisYTickFormat: ChartAxisTickFormat = .number,
                axisXLabelRotation: Angle = .degrees(0),
                axisFont: Font = .callout,
                axisFontColor: Color = .primary,
                axisLabelsYPosition: AxisLabelsYPosition = .leading) {
        self.axisYLabels = axisYLabels
        self.axisXLabels = axisXLabels
        self.axisXRange = axisXRange
        self.axisXDomainMode = axisXDomainMode
        self.axisXAutoTickCount = axisXAutoTickCount
        self.axisYAutoTickCount = axisYAutoTickCount
        self.axisXTickFormat = axisXTickFormat
        self.axisYTickFormat = axisYTickFormat
        self.axisXLabelRotation = axisXLabelRotation
        self.axisFont = axisFont
        self.axisFontColor = axisFontColor
        self.axisLabelsYPosition = axisLabelsYPosition
    }
}
