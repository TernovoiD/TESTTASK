import SwiftUI

struct SignUpResultView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(.registerSuccess)
                .resizable()
                .scaledToFit()
                .setHeight(200)
            Text(LocalizedText.registerSuccess)
                .font(.nunito(size: 20))
            PrimaryButton(LocalizedText.Button.gotIt, disabled: false) { }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            closeButton
                .foregroundStyle(.black.opacity(0.48))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .padding(24)
    }
}

#Preview {
    SignUpResultView()
}

private extension SignUpResultView {
    var closeButton: some View {
        Button {
            
        } label: {
            Image(systemName: IconNames.xMark.rawValue)
                .resizable()
                .scaledToFit()
                .setHeight(14)
                .frame(maxWidth: 24, maxHeight: 24)
                .bold()
        }
    }
}
