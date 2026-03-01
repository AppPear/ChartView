import SwiftUI

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
    public var axisFont: Font
    public var axisFontColor: Color
    public var axisLabelsYPosition: AxisLabelsYPosition

    public init(axisYLabels: [String] = [],
                axisXLabels: [ChartXAxisLabel] = [],
                axisXRange: ClosedRange<Double>? = nil,
                axisXDomainMode: ChartXDomainMode = .categorical,
                axisFont: Font = .callout,
                axisFontColor: Color = .primary,
                axisLabelsYPosition: AxisLabelsYPosition = .leading) {
        self.axisYLabels = axisYLabels
        self.axisXLabels = axisXLabels
        self.axisXRange = axisXRange
        self.axisXDomainMode = axisXDomainMode
        self.axisFont = axisFont
        self.axisFontColor = axisFontColor
        self.axisLabelsYPosition = axisLabelsYPosition
    }
}
