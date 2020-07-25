import SwiftUI

public class ChartData: ObservableObject {
    @Published public var data: [Double] = []

    public init(_ data: [Double]) {
        self.data = data
    }

    public init() {
        self.data = []
    }
}
