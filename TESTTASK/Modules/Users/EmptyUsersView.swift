import SwiftUI

struct EmptyUsersView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(.users)
                .resizable()
                .scaledToFit()
                .setHeight(200)
            Text(LocalizedText.noUsers)
                .font(.nunito(size: 20))
        }
        
    }
}

#Preview {
    EmptyUsersView()
}
