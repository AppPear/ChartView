import SwiftUI

/// A single "row" (slice) of data, a view in a `PieChart`
public struct PieChartRow: View {
    @Environment(\.chartInteractionValue) private var chartValue
    @Environment(\.chartSelectionHandler) private var selectionHandler

    var chartData: ChartData
    var style: ChartStyle

    var slices: [PieSlice] {
        var tempSlices: [PieSlice] = []
        var lastEndDeg: Double = 0
        let maxValue: Double = chartData.points.reduce(0, +)

        for slice in chartData.points {
            let normalized: Double = Double(slice) / (maxValue == 0 ? 1 : maxValue)
            let startDeg = lastEndDeg
            let endDeg = lastEndDeg + (normalized * 360)
            lastEndDeg = endDeg
            tempSlices.append(PieSlice(startDeg: startDeg, endDeg: endDeg, value: slice))
        }

        return tempSlices
    }

    @State private var currentTouchedIndex = -1 {
        didSet {
            guard oldValue != currentTouchedIndex else {
                return
            }

            if currentTouchedIndex == -1 {
                ChartSelectionDispatcher.publish(chartValue: chartValue,
                                                handler: selectionHandler,
                                                value: nil,
                                                index: nil,
                                                isActive: false)
            } else {
                ChartSelectionDispatcher.publish(chartValue: chartValue,
                                                handler: selectionHandler,
                                                value: slices[currentTouchedIndex].value,
                                                index: currentTouchedIndex,
                                                isActive: true)
            }
        }
    }

    public var body: some View {
        GeometryReader { geometry in
            let rect = geometry.frame(in: .local).sanitized
            let total = max(0.0001, chartData.points.reduce(0, +))
            ZStack {
                ForEach(Array(slices.indices), id: \.self) { index in
                    PieChartCell(rect: rect,
                                 startDeg: slices[index].startDeg,
                                 endDeg: slices[index].endDeg,
                                 index: index,
                                 backgroundColor: style.backgroundColor.startColor,
                                 accentColor: style.foregroundColor.rotate(for: index))
                        .scaleEffect(currentTouchedIndex == index ? 1.1 : 1)
                        .animation(Animation.spring())
                        .accessibilityElement(children: .ignore)
                        .accessibility(label: Text("Slice \(index + 1), value \(formatted(slices[index].value)), \(formatted((slices[index].value / total) * 100)) percent"))
                }
            }
            .frame(width: rect.width, height: rect.height, alignment: .topLeading)
            .gesture(DragGesture()
                .onChanged({ value in
                    let isTouchInPie = isPointInCircle(point: value.location, circleRect: rect)
                    if isTouchInPie {
                        let touchDegree = degree(for: value.location, inCircleRect: rect)
                        currentTouchedIndex = slices.firstIndex(where: { $0.startDeg < touchDegree && $0.endDeg > touchDegree }) ?? -1
                    } else {
                        currentTouchedIndex = -1
                    }
                })
                .onEnded({ _ in
                    currentTouchedIndex = -1
                })
            )
        }
    }

    private func formatted(_ value: Double) -> String {
        if abs(value.rounded() - value) < 0.001 {
            return String(Int(value.rounded()))
        }
        return String(format: "%.1f", value)
    }
}
