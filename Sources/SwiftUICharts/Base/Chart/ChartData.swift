import SwiftUI

/// An observable wrapper for an array of data for use in any chart
public class ChartData: ObservableObject {
    @Published public var data: [Double] = []

	/// Initialize with data array
	/// - Parameter data: Array of `Double`
    public init(_ data: [Double]) {
        self.data = data
    }

    public init() {
        self.data = []
    }
}
