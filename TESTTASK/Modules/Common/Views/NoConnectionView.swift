import SwiftUI

struct NoConnectionView: View {
    @EnvironmentObject private var internet: ConnectionMonitor
    
    var body: some View {
        VStack(spacing: 24) {
            Image(.lostConnection)
                .resizable()
                .scaledToFit()
                .setHeight(200)
            Text(LocalizedText.noConnection)
                .font(.nunito(size: 20))
                .foregroundStyle(.black.opacity(0.87))
            PrimaryButton(LocalizedText.Button.tryAgain, disabled: false) { internet.checkConnection() }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.customBackground)
    }
}

#Preview {
    NoConnectionView()
        .environmentObject(ConnectionMonitor())
}
