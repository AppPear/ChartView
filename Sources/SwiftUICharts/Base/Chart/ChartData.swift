import SwiftUI

/// An observable wrapper for an array of data for use in any chart
public class ChartData: ObservableObject {
    @Published public var data: [Double] = []

	/// <#Description#>
	/// - Parameter data: <#data description#>
    public init(_ data: [Double]) {
        self.data = data
    }

    public init() {
        self.data = []
    }
}
