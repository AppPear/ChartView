import SwiftUI

public struct ChartGrid<Content: View>: View {
    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ZStack{
            self.content()
        }
    }
}

