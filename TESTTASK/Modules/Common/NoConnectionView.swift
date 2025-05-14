import SwiftUI

struct NoConnectionView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(.lostConnection)
                .resizable()
                .scaledToFit()
                .setHeight(200)
            Text(LocalizedText.noConnection)
                .font(.nunito(size: 20))
            PrimaryButton(LocalizedText.Button.tryAgain, disabled: false) { }
        }
        
    }
}

#Preview {
    NoConnectionView()
}
