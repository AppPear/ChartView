import SwiftUI

public struct ChartGrid<Content: View>: View {
    let content: () -> Content
    public var gridOptions = GridOptions()

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ZStack {
            ChartGridShape(numberOfHorizontalLines: gridOptions.numberOfHorizontalLines,
                           numberOfVerticalLines: gridOptions.numberOfVerticalLines)
            .stroke(gridOptions.color, style: gridOptions.strokeStyle)
            if gridOptions.showBaseLine {
                ChartGridBaseShape()
                    .stroke(gridOptions.color, style: gridOptions.baseStrokeStyle)
                    .rotationEffect(.degrees(180), anchor: .center)
            }
            self.content()
        }
    }
}
