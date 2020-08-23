import SwiftUI

public enum ChartLabelType {
    case title
    case subTitle
    case largeTitle
    case custom(size: CGFloat, padding: EdgeInsets, color: Color)
    case legend
}

public enum ChartLabelFormat {
    case custom(completion: (Double) -> String)
    case none
    
    func format(value: Double) -> String {
        switch self {
        case .custom(let completion):
            return completion(value)
        case .none:
            return String(format: "%.01f", value)
        }
    }
}

public struct ChartLabel: View {
    @EnvironmentObject var chartValue: ChartValue
    @State var textToDisplay:String = ""
    
    private var title: String
    private var format: ChartLabelFormat
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
            return .black
        case .legend:
            return .gray
        case .subTitle:
            return .black
        case .largeTitle:
            return .black
        case .custom(_, _, let color):
            return color
        }
    }

    public init (_ title: String, format: ChartLabelFormat,
                 type: ChartLabelType = .title) {
        self.title = title
        self.format = format
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
                    self.setTextToDisplay()
                }
            if !self.chartValue.interactionInProgress {
                Spacer()
            }
        }
    }
    
    func setTextToDisplay() {
        self.textToDisplay = self.chartValue.interactionInProgress ? format.format(value: self.chartValue.currentValue) : self.title
    }
}


