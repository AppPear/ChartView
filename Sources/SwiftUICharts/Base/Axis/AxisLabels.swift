import SwiftUI

public struct AxisLabels<Content: View>: View {
    var axisLabelsData = AxisLabelsData()
    let content: () -> Content
    // font
    // foregroundColor

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        HStack {
            VStack {
                ForEach(Array(axisLabelsData.axisYLabels.reversed().enumerated()), id: \.element) { index, axisYData in
                    Text(axisYData)
                    if index != axisLabelsData.axisYLabels.count - 1 {
                        Spacer()
                    }
                }
            }
            .padding([.trailing], 8.0)
            .padding([.bottom], axisLabelsData.axisXLabels.count > 0 ? 28.0 : 0)
            .frame(maxHeight: .infinity)
            VStack {
                self.content()
                HStack {
                    ForEach(Array(axisLabelsData.axisXLabels.enumerated()), id: \.element) { index, axisXData in
                        Text(axisXData)
                        if index != axisLabelsData.axisXLabels.count - 1 {
                            Spacer()
                        }
                    }
                }
            }
            .padding([.top, .bottom], 10.0)
        }
    }
}
