import Foundation

final class SignUpViewModel: ObservableObject {
    let service: UserService
    
    init(with service: UserService) {
        self.service = service
    }
}
