import SwiftUI

/// What kind of label - this affects color, size, position of the label.
public enum ChartLabelType {
    case title
    case subTitle
    case largeTitle
    case custom(size: CGFloat, padding: EdgeInsets, color: Color)
    case legend
}

/// A chart may contain any number of labels in pre-set positions based on their `ChartLabelType`.
public struct ChartLabel: View {
    @Environment(\.chartInteractionValue) private var chartValue

    private var title: String
    private var format: String
    private let labelType: ChartLabelType

    public init(_ title: String,
                type: ChartLabelType = .title,
                format: String = "%.01f") {
        self.title = title
        self.labelType = type
        self.format = format
    }

    public var body: some View {
        if let chartValue = chartValue {
            ChartLabelObservedValue(title: title,
                                    format: format,
                                    labelSize: labelSize,
                                    labelPadding: labelPadding,
                                    labelColor: labelColor,
                                    chartValue: chartValue)
        } else {
            HStack {
                Text(title)
                    .font(.system(size: labelSize))
                    .bold()
                    .foregroundColor(labelColor)
                    .padding(labelPadding)
                Spacer()
            }
        }
    }

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
            return EdgeInsets(top: 16.0, leading: 0, bottom: 0.0, trailing: 8.0)
        case .legend:
            return EdgeInsets(top: 4.0, leading: 0, bottom: 0.0, trailing: 8.0)
        case .subTitle:
            return EdgeInsets(top: 8.0, leading: 0, bottom: 0.0, trailing: 8.0)
        case .largeTitle:
            return EdgeInsets(top: 24.0, leading: 0, bottom: 0.0, trailing: 8.0)
        case .custom(_, let padding, _):
            return padding
        }
    }

    private var labelColor: Color {
        switch labelType {
        case .title:
            return .primary
        case .legend:
            return .secondary
        case .subTitle:
            return .primary
        case .largeTitle:
            return .primary
        case .custom(_, _, let color):
            return color
        }
    }
}

private struct ChartLabelObservedValue: View {
    @ObservedObject var chartValue: ChartValue

    let title: String
    let format: String
    let labelSize: CGFloat
    let labelPadding: EdgeInsets
    let labelColor: Color

    init(title: String,
         format: String,
         labelSize: CGFloat,
         labelPadding: EdgeInsets,
         labelColor: Color,
         chartValue: ChartValue) {
        self.title = title
        self.format = format
        self.labelSize = labelSize
        self.labelPadding = labelPadding
        self.labelColor = labelColor
        self.chartValue = chartValue
    }

    var body: some View {
        HStack {
            Text(chartValue.interactionInProgress
                 ? String(format: format, chartValue.currentValue)
                 : title)
                .font(.system(size: labelSize))
                .bold()
                .foregroundColor(labelColor)
                .padding(labelPadding)

            if !chartValue.interactionInProgress {
                Spacer()
            }
        }
    }
}
