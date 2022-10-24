import SwiftUI

public struct ViewSizeData: Identifiable, Equatable, Hashable {
    public let id: UUID = UUID()
    public let size: CGSize

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
