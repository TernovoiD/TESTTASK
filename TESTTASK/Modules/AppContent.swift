import SwiftUI

struct AppContent: View {
    @StateObject private var router = AppRouter(current: .launching)
    @StateObject private var internet = ConnectionMonitor()
    
    var body: some View {
        Group {
            switch router.current {
            case .launching:
                LaunchView()
                    .transition(.move(edge: .leading))
            case .home:
                HomeView()
                    .transition(.move(edge: .trailing))
            case .noConnection:
                NoConnectionView()
                    .environmentObject(internet)
                    .transition(.move(edge: .leading))
            case .registerSuccess(let state):
                ResultView(success: state)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.spring, value: router.current)
        .environmentObject(router)
        .onAppear { finishLaunching() }
        .onChange(of: internet.isConnected) { _, isConnected in
            router.current = isConnected ? .home : .noConnection
        }
    }
    
    private func finishLaunching() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut) { router.current = .home }
        }
    }
}

#Preview {
    AppContent()
}
