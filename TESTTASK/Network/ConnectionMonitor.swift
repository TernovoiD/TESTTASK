import Foundation
import Network

class ConnectionMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected: Bool = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    func checkConnection() {
        self.isConnected = monitor.currentPath.status == .satisfied
    }
    
    deinit {
        monitor.cancel()
    }
}
