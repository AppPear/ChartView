import SwiftUI

extension ChartGrid {
    public func setNumberOfHorizontalLines(_ numberOfLines: Int) -> ChartGrid {
        self.gridOptions.numberOfHorizontalLines = numberOfLines
        return self
    }

    public func setNumberOfVerticalLines(_ numberOfLines: Int) -> ChartGrid {
        self.gridOptions.numberOfVerticalLines = numberOfLines
        return self
    }

    public func setStoreStyle(_ strokeStyle: StrokeStyle) -> ChartGrid {
        self.gridOptions.strokeStyle = strokeStyle
        return self
    }

    public func setColor(_ color: Color) -> ChartGrid {
        self.gridOptions.color = color
        return self
    }

    public func showBaseLine(_ show: Bool, with style: StrokeStyle? = nil) -> ChartGrid {
        self.gridOptions.showBaseLine = show
        if let style = style {
            self.gridOptions.baseStrokeStyle = style
        }
        return self
    }
}
