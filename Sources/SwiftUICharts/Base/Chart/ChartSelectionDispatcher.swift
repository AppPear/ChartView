import Foundation

enum ChartSelectionDispatcher {
    static func publish(chartValue: ChartValue?,
                        handler: ChartSelectionHandler?,
                        value: Double?,
                        index: Int?,
                        isActive: Bool) {
        chartValue?.interactionInProgress = isActive
        if isActive, let value = value {
            chartValue?.currentValue = value
        }

        handler?(ChartSelectionEvent(value: value,
                                     index: index,
                                     isActive: isActive))
    }
}
