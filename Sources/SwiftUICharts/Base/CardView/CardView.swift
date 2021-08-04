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

	/// The content and behavior of the `CardView`.
	///
	///
    public var body: some View {
        ZStack{
            if showShadow {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: Color(white: 0.9, opacity: 1), radius: 8)
            }
            VStack (alignment: .leading) {
                self.content()
            }
            .clipShape(RoundedRectangle(cornerRadius: showShadow ? 20 : 0))
        }
    }
}
