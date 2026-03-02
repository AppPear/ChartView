import SwiftUI

private struct ChartSeriesIDModifier: ViewModifier {
    @Environment(\.chartSeriesConfig) private var currentConfig

    let seriesID: String?

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.seriesID = seriesID
        return content.environment(\.chartSeriesConfig, updated)
    }
}

private struct ChartHiddenSeriesModifier: ViewModifier {
    @Environment(\.chartSeriesConfig) private var currentConfig

    let hiddenSeries: Set<String>

    func body(content: Content) -> some View {
        var updated = currentConfig
        updated.hiddenSeriesIDs = hiddenSeries
        return content.environment(\.chartSeriesConfig, updated)
    }
}

public extension View {
    func chartSeriesID(_ id: String?) -> some View {
        modifier(ChartSeriesIDModifier(seriesID: id))
    }

    func chartHiddenSeries(_ ids: Set<String>) -> some View {
        modifier(ChartHiddenSeriesModifier(hiddenSeries: ids))
    }
}
