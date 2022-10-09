import SwiftUI

public final class AxisLabelsStyle: ObservableObject {
    @Published public var axisFont: Font = .callout
    @Published public var axisFontColor: Color = .primary
    @Published var axisLabelsYPosition: AxisLabelsYPosition = .leading
    @Published var axisLabelsXPosition: AxisLabelsXPosition = .bottom
    public init() {
        // no-op
    }
}
