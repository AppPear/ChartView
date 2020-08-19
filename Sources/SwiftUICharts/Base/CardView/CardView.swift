import SwiftUI

/// View containing data and some kind of chart content
public struct CardView<Content: View>: View, ChartBase {
    public var chartData = ChartData()
    let content: () -> Content

    private var showShadow: Bool

    @EnvironmentObject var style: ChartStyle

	/// Initialize with view options and a nested `ViewBuilder`
	/// - Parameters:
	///   - showShadow: should card have a rounded-rectangle shadow around it
	///   - content: <#content description#>
    public init(showShadow: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.showShadow = showShadow
        self.content = content
    }

    public var body: some View {
        ZStack{
            if showShadow {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: Color.gray, radius: 8)
            }
            VStack {
                self.content()
            }
            .clipShape(RoundedRectangle(cornerRadius: showShadow ? 20 : 0))
        }
    }
}
