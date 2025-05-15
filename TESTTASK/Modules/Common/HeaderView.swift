import SwiftUI

struct HeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.nunito(size: 20))
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: 56 * Screen.scaleFactor)
            .background(.customPrimary, ignoresSafeAreaEdges: [ ])
    }
}

#Preview {
    HeaderView(title: LocalizedText.TopBar.reguestGETTitle)
}
