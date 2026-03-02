import SwiftUI

public struct ChartGrid<Content: View>: View {
    let content: () -> Content

    @Environment(\.chartGridConfig) private var gridConfig

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ZStack {
            ChartGridShape(numberOfHorizontalLines: gridConfig.numberOfHorizontalLines,
                           numberOfVerticalLines: gridConfig.numberOfVerticalLines)
                .stroke(gridConfig.color, style: gridConfig.strokeStyle)
            if gridConfig.showBaseLine {
                ChartGridBaseShape()
                    .stroke(gridConfig.color, style: gridConfig.baseStrokeStyle)
                    .rotationEffect(.degrees(180), anchor: .center)
            }
            content()
        }
    }
}
