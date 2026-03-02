import SwiftUI

public protocol ViewPreferenceKey: PreferenceKey where Value == [ViewSizeData] {}

public extension ViewPreferenceKey {
    static var defaultValue: [ViewSizeData] {
        []
    }

    static func reduce(value: inout [ViewSizeData], nextValue: () -> [ViewSizeData]) {
        value.append(contentsOf: nextValue())
    }
}
