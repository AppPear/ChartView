import SwiftUI

public enum ChartXDomainMode {
    case categorical
    case numeric
}

private struct ChartDataPointsKey: EnvironmentKey {
    static let defaultValue: [(Double, Double)] = []
}

private struct ChartXDomainModeKey: EnvironmentKey {
    static let defaultValue: ChartXDomainMode = .numeric
}

private struct ChartXRangeKey: EnvironmentKey {
    static let defaultValue: ClosedRange<Double>? = nil
}

private struct ChartYRangeKey: EnvironmentKey {
    static let defaultValue: ClosedRange<Double>? = nil
}

private struct ChartStyleKey: EnvironmentKey {
    static let defaultValue = ChartStyle(backgroundColor: Color.primary.opacity(0.04), foregroundColor: .orangeBright)
}

private struct ChartInteractionValueKey: EnvironmentKey {
    static let defaultValue: ChartValue? = nil
}

private struct ChartGridConfigKey: EnvironmentKey {
    static let defaultValue = ChartGridConfig()
}

private struct ChartAxisConfigKey: EnvironmentKey {
    static let defaultValue = ChartAxisConfig()
}

private struct ChartLineConfigKey: EnvironmentKey {
    static let defaultValue = ChartLineConfig()
}

private struct ChartSeriesConfigKey: EnvironmentKey {
    static let defaultValue = ChartSeriesConfig()
}

public extension EnvironmentValues {
    var chartDataPoints: [(Double, Double)] {
        get { self[ChartDataPointsKey.self] }
        set { self[ChartDataPointsKey.self] = newValue }
    }

    var chartXDomainMode: ChartXDomainMode {
        get { self[ChartXDomainModeKey.self] }
        set { self[ChartXDomainModeKey.self] = newValue }
    }

    var chartXRange: ClosedRange<Double>? {
        get { self[ChartXRangeKey.self] }
        set { self[ChartXRangeKey.self] = newValue }
    }

    var chartYRange: ClosedRange<Double>? {
        get { self[ChartYRangeKey.self] }
        set { self[ChartYRangeKey.self] = newValue }
    }

    var chartStyle: ChartStyle {
        get { self[ChartStyleKey.self] }
        set { self[ChartStyleKey.self] = newValue }
    }

    var chartInteractionValue: ChartValue? {
        get { self[ChartInteractionValueKey.self] }
        set { self[ChartInteractionValueKey.self] = newValue }
    }

    var chartGridConfig: ChartGridConfig {
        get { self[ChartGridConfigKey.self] }
        set { self[ChartGridConfigKey.self] = newValue }
    }

    var chartAxisConfig: ChartAxisConfig {
        get { self[ChartAxisConfigKey.self] }
        set { self[ChartAxisConfigKey.self] = newValue }
    }

    var chartLineConfig: ChartLineConfig {
        get { self[ChartLineConfigKey.self] }
        set { self[ChartLineConfigKey.self] = newValue }
    }

    var chartSeriesConfig: ChartSeriesConfig {
        get { self[ChartSeriesConfigKey.self] }
        set { self[ChartSeriesConfigKey.self] = newValue }
    }
}
