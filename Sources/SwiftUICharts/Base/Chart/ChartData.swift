import SwiftUI

/// An observable wrapper for an array of data for use in any chart
public class ChartData: ObservableObject {
    @Published public var data: [(String, Double)] = []

    var points: [Double] {
        data.map { $0.1 }
    }

    var values: [String] {
        data.map { $0.0 }
    }

	/// Initialize with data array
	/// - Parameter data: Array of `Double`
    public init(_ data: [Double]) {
        self.data = data.map { ("", $0) }
    }

    public init(_ data: [(String, Double)]) {
        self.data = data
    }

    public init() {
        self.data = []
    }
}
