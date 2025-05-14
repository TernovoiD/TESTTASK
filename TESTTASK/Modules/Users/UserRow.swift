import SwiftUI

struct UserRow: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(.avatar)
                .resizable()
                .scaledToFit()
                .setHeight(50)
            VStack(alignment: .leading, spacing: 0) {
                Text("Seraphina Anastasia Isolde Aurelia Celestina von Hohenzollern")
                    .font(.nunito(size: 18))
                    .lineLimit(3)
                Text("Backend developer")
                    .opacity(0.6)
                    .padding(.top, 4)
                    .padding(.bottom, 8)
                    .lineLimit(1)
                Text("maximus_wilderman_ronaldo_schuppemaximus_wilderman_ronaldo_schuppe")
                    .padding(.bottom, 4)
                    .lineLimit(1)
                Text("+38 (098) 278 76 24")
                    .padding(.bottom, 4)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.nunito(size: 14))
            .opacity(0.87)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
    }
}

#Preview {
    UserRow()
}
