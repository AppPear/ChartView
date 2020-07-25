import SwiftUI

extension View {
    public func chartStyle(_ style: ChartStyle) -> some View {
        self.environmentObject(style)
    }
}
