import SwiftUI

public struct ChartGrid<Content: View>: View, ChartBase {
    public var chartData = ChartData()
    let content: () -> Content

    @EnvironmentObject var data: ChartData
    @EnvironmentObject var style: ChartStyle

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ZStack{
            self.content()
        }
    }
}

