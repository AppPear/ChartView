import Foundation

public enum ChartPerformanceMode {
    case none
    case automatic(threshold: Int, maxPoints: Int, simplifyLineStyle: Bool)
    case downsample(maxPoints: Int, simplifyLineStyle: Bool)
}

public struct ChartPerformanceConfig {
    public var mode: ChartPerformanceMode

    public init(mode: ChartPerformanceMode = .none) {
        self.mode = mode
    }
}
