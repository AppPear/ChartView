import SwiftUI

public struct ChartLegendItem: Identifiable {
    public let id: String
    public let title: String
    public let color: ColorGradient

    public init(id: String, title: String, color: ColorGradient) {
        self.id = id
        self.title = title
        self.color = color
    }
}

public struct ChartLegend: View {
    private let items: [ChartLegendItem]
    @Binding private var hiddenSeries: Set<String>

    public init(items: [ChartLegendItem], hiddenSeries: Binding<Set<String>>) {
        self.items = items
        self._hiddenSeries = hiddenSeries
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(items) { item in
                Button(action: { toggle(item.id) }) {
                    HStack(spacing: 8) {
                        Circle()
                            .fill(item.color.linearGradient(from: .topLeading, to: .bottomTrailing))
                            .frame(width: 10, height: 10)
                            .opacity(isHidden(item.id) ? 0.25 : 1)

                        Text(item.title)
                            .font(.caption)
                            .foregroundColor(.primary)
                            .strikethrough(isHidden(item.id), color: .secondary)

                        Spacer(minLength: 0)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
                .accessibility(label: Text(isHidden(item.id) ? "Show \(item.title)" : "Hide \(item.title)"))
            }
        }
    }

    private func isHidden(_ id: String) -> Bool {
        hiddenSeries.contains(id)
    }

    private func toggle(_ id: String) {
        if hiddenSeries.contains(id) {
            hiddenSeries.remove(id)
        } else {
            hiddenSeries.insert(id)
        }
    }
}
