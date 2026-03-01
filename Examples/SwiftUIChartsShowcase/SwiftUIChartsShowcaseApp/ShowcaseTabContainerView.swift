import SwiftUI

struct ShowcaseTabContainerView: View {
    var body: some View {
        TabView {
            ShowcaseHomeView()
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Showcase")
                }
                .tag(0)

            ShowcaseDynamicLabView()
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("Dynamic")
                }
                .tag(1)
        }
    }
}

struct ShowcaseTabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ShowcaseTabContainerView()
    }
}
