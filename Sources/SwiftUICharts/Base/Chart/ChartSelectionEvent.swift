import Foundation

public struct ChartSelectionEvent {
    public let value: Double?
    public let index: Int?
    public let isActive: Bool

    public init(value: Double?,
                index: Int?,
                isActive: Bool) {
        self.value = value
        self.index = index
        self.isActive = isActive
    }
}

public typealias ChartSelectionHandler = (ChartSelectionEvent) -> Void
