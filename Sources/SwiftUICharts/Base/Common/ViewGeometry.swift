import SwiftUI

public struct ViewGeometry<T>: View where T: PreferenceKey {
    public var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: T.self, value: [ViewSizeData(size: geometry.size)] as! T.Value)
        }
    }
}
