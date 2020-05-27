import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol ChartType {
    associatedtype Body: View

    func makeChart(configuration: Self.Configuration, style: Self.Style) -> Self.Body

    typealias Configuration = ChartTypeConfiguration
    typealias Style = ChartStyle
}
