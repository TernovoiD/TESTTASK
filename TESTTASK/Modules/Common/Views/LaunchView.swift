import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            Color.customPrimary
                .ignoresSafeArea()
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 160)
        }
    }
}

#Preview {
    LaunchView()
}
