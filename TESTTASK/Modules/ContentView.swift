import SwiftUI

struct ContentView: View {
    private let service = UserService()
    
    var body: some View {
        VStack {
            Text("This is a REGULAR text")
            Text("This is a NUNITO text")
                .font(.nunito(size: 17))
            Image(.lostConnection)
                .resizable()
                .scaledToFit()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
