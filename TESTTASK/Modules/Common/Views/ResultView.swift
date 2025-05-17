import SwiftUI

struct ResultView: View {
    @EnvironmentObject private var router: AppRouter
    let success: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Image(success ? .registerSuccess : .registerFailure)
                .resizable()
                .scaledToFit()
                .setHeight(200)
            Text(success ? LocalizedText.registerSuccess : LocalizedText.registerFailure)
                .font(.nunito(size: 20))
                .foregroundStyle(.black.opacity(0.87))
            PrimaryButton(LocalizedText.Button.gotIt, disabled: false) {
                router.current = .home
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay { closeButton }
        .padding(24)
        .background(.customBackground)
    }
}

#Preview {
    ResultView(success: true)
        .environmentObject(AppRouter(current: .launching))
}

private extension ResultView {
    var closeButton: some View {
        Button { router.current = .home } label: {
            Image(systemName: IconNames.xMark.rawValue)
                .resizable()
                .scaledToFit()
                .setHeight(14)
                .frame(maxWidth: 24, maxHeight: 24)
                .bold()
        }
        .foregroundStyle(.black.opacity(0.48))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
}
