import SwiftUI

public struct ChartGridConfig {
    public var numberOfHorizontalLines: Int
    public var numberOfVerticalLines: Int
    public var strokeStyle: StrokeStyle
    public var color: Color
    public var showBaseLine: Bool
    public var baseStrokeStyle: StrokeStyle

    public init(numberOfHorizontalLines: Int = 3,
                numberOfVerticalLines: Int = 3,
                strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 1, lineCap: .round, dash: [5, 10]),
                color: Color = Color(white: 0.85),
                showBaseLine: Bool = true,
                baseStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5, 0])) {
        self.numberOfHorizontalLines = numberOfHorizontalLines
        self.numberOfVerticalLines = numberOfVerticalLines
        self.strokeStyle = strokeStyle
        self.color = color
        self.showBaseLine = showBaseLine
        self.baseStrokeStyle = baseStrokeStyle
    }
}
