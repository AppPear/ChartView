import SwiftUI

extension AxisLabels {
    public func setAxisYLabels(_ labels: [String],
                               position: AxisLabelsYPosition = .leading) -> AxisLabels {
        self.axisLabelsData.axisYLabels = labels
        self.axisLabelsStyle.axisLabelsYPosition = position
        return self
    }

    public func setAxisXLabels(_ labels: [String]) -> AxisLabels {
        self.axisLabelsData.axisXLabels = labels
        return self
    }

    public func setAxisYLabels(_ labels: [(Double, String)],
                               range: ClosedRange<Int>,
                               position: AxisLabelsYPosition = .leading) -> AxisLabels {
        let overreach = range.overreach + 1
        var labelArray = [String](repeating: "", count: overreach)
        labels.forEach {
            let index = Int($0.0) - range.lowerBound
            if labelArray[safe: index] != nil {
                labelArray[index] = $0.1
            }
        }

        self.axisLabelsData.axisYLabels = labelArray
        self.axisLabelsStyle.axisLabelsYPosition = position

        return self
    }

    public func setAxisXLabels(_ labels: [(Double, String)], range: ClosedRange<Int>) -> AxisLabels {
        let overreach = range.overreach + 1
        var labelArray = [String](repeating: "", count: overreach)
        labels.forEach {
            let index = Int($0.0) - range.lowerBound
            if labelArray[safe: index] != nil {
                labelArray[index] = $0.1
            }
        }

        self.axisLabelsData.axisXLabels = labelArray
        return self
    }

    public func setColor(_ color: Color) -> AxisLabels {
        self.axisLabelsStyle.axisFontColor = color
        return self
    }

    public func setFont(_ font: Font) -> AxisLabels {
        self.axisLabelsStyle.axisFont = font
        return self
    }
}
