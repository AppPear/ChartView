import SwiftUI

public class ChartValue: ObservableObject {
    @Published var currentValue: Double = 0
    @Published var interactionInProgress: Bool = false
}
