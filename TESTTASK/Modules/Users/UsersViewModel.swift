import Foundation

final class UsersViewModel: ObservableObject {
    let service: UserService
    
    @Published var users = [User]()
    @Published var loading = false
    var lastPage = false
    private var currentPage = 1
    
    init(with service: UserService) {
        self.service = service
    }
    
    func loadUsers() async {
        loading = true
        do {
            let loadedUsers = try await service.load(page: currentPage)
            if loadedUsers.count < 6 { lastPage = true }
            users.append(contentsOf: loadedUsers)
            loading = false
        } catch let error {
            print(error.localizedDescription)
            loading = false
            lastPage = true
        }
    }
    
    func nextPage() async {
        currentPage += 1
        await loadUsers()
    }
}
