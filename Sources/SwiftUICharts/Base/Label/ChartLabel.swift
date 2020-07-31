import SwiftUI

public enum ChartLabelType {
    case title
    case subTitle
    case largeTitle
    case custom(size: CGFloat, padding: EdgeInsets, color: Color)
    case legend
}

public struct ChartLabel: View {
    @EnvironmentObject var chartValue: ChartValue
    @State var textToDisplay:String = ""

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
        case .custom(let size, _, _):
            return size
        }
    }

    private var labelPadding: EdgeInsets {
        switch labelType {
        case .title:
            return EdgeInsets(top: 16.0, leading: 8.0, bottom: 0.0, trailing: 8.0)
        case .legend:
            return EdgeInsets(top: 4.0, leading: 8.0, bottom: 0.0, trailing: 8.0)
        case .subTitle:
            return EdgeInsets(top: 8.0, leading: 8.0, bottom: 0.0, trailing: 8.0)
        case .largeTitle:
            return EdgeInsets(top: 24.0, leading: 8.0, bottom: 0.0, trailing: 8.0)
        case .custom(_, let padding, _):
            return padding
        }
    }

    private let labelType: ChartLabelType

    private var labelColor: Color {
        switch labelType {
        case .title:
            return Color(UIColor.label)
        case .legend:
            return Color(UIColor.secondaryLabel)
        case .subTitle:
            return Color(UIColor.label)
        case .largeTitle:
            return Color(UIColor.label)
        case .custom(_, _, let color):
            return color
        }
    }

    public init (_ title: String,
                 type: ChartLabelType = .title) {
        self.title = title
        labelType = type
    }

    public var body: some View {
        HStack {
            Text(textToDisplay)
                .font(.system(size: labelSize))
                .bold()
                .foregroundColor(self.labelColor)
                .padding(self.labelPadding)
                .onAppear {
                    self.textToDisplay = self.title
                }
                .onReceive(self.chartValue.objectWillChange) { _ in
                    self.textToDisplay = self.chartValue.interactionInProgress ? String(format: "%.01f", self.chartValue.currentValue) : self.title
                }
            if !self.chartValue.interactionInProgress {
                Spacer()
            }
        }
    }
}
