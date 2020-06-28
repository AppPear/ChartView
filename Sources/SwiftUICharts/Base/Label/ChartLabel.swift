import SwiftUI

public enum ChartLabelType {
    case title
    case subTitle
    case largeTitle
    case custom(size: CGFloat)
    case legend
}

public struct ChartLabel: View {
    @Environment(\.chartValue) private var chartValue: ChartValue

    @State var textToDisplay = ""
    @State var isInteractionInProgress: Bool = false

    private var title: String

    private var labelSize: CGFloat {
        switch labelType {
        case .title:
            return 32.0
        case .legend:
            return 14.0
        case .subTitle:
            return 24.0
        case .largeTitle:
            return 38.0
        case .custom(let size):
            return size
        }
    }

    private let labelType: ChartLabelType

    private var labelColor: Color {
        switch labelType {
        case .title:
            return .black
        case .legend:
            return .gray
        case .subTitle:
            return .black
        case .largeTitle:
            return .black
        case .custom(_):
            return .black
        }
    }

    public init (_ title: String,
                 type: ChartLabelType = .title) {
        self.title = title
        labelType = type
    }

    public var body: some View {
        VStack (alignment: self.isInteractionInProgress ? .center : .leading) {
            Text(textToDisplay)
                .font(.system(size: labelSize))
                .bold()
                .foregroundColor(self.labelColor)
                .onAppear {
                    self.textToDisplay = title
                }
                .onReceive(self.chartValue.objectWillChange) { _ in
                    self.textToDisplay = self.chartValue.interactionInProgress ? String(format: "%.01f", self.chartValue.currentValue) : self.title
                    self.isInteractionInProgress = self.chartValue.interactionInProgress
                }
        }
    }
}
