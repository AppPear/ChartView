import SwiftUI

public enum ChartLabelSize: CGFloat {
    case small = 16.0
    case normal = 24.0
    case large = 32.0
}

public enum ChartLabelType {
    case title
    case legend
}

public struct ChartLabel: View {
    private let text: String
    private let labelSize: ChartLabelSize
    private let labelType: ChartLabelType

    private var labelColor: Color {
        switch labelType {
        case .title:
            return .black
        case .legend:
            return .gray
        }
    }

    public init (_ text: String,
                 type: ChartLabelType = .title,
                 size: ChartLabelSize = .normal) {
        self.text = text
        labelType = type
        labelSize = size
    }

    public var body: some View {
        Text(self.text)
            .font(.system(size: labelSize.rawValue))
            .bold()
            .foregroundColor(self.labelColor)
            .padding([.top, .bottom], 16.0)
    }
}
