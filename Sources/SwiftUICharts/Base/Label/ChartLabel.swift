import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol ChartLabel {

    associatedtype Body : View

    func makeLabel(configuration: Self.Configuration) -> Self.Body

    typealias Configuration = ChartLabelConfiguration
}
