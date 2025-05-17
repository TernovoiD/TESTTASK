import Foundation

final class AppRouter: ObservableObject {
    @Published var current: Route
    
    init(current: Route) {
        self.current = current
    }
    
    enum Route: Equatable {
        case launching, home, noConnection, registerSuccess(Bool)
    }
}
