import SwiftUI

public struct ChartSeriesConfig {
    public var seriesID: String?
    public var hiddenSeriesIDs: Set<String>

    public init(seriesID: String? = nil,
                hiddenSeriesIDs: Set<String> = []) {
        self.seriesID = seriesID
        self.hiddenSeriesIDs = hiddenSeriesIDs
    }
}
