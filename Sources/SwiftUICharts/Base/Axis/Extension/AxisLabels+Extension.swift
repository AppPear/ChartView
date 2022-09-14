import SwiftUI

extension AxisLabels {
    public func setAxisYLabels(_ labels: [String]) -> AxisLabels {
        self.axisLabelsData.axisYLabels = labels
        return self
    }

    public func setAxisXLabels(_ labels: [String]) -> AxisLabels {
        self.axisLabelsData.axisXLabels = labels
        return self
    }
}
