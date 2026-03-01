import SwiftUI

extension View {
    func toStandardCoordinateSystem() -> some View {
        self
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}
