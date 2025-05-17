import Foundation

final class SignUpViewModel: ObservableObject {
    let service: UserService
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var positions = [Position]()
    @Published var selectedPositon: Position?
    private var token = ""
    
    enum Field {
        case name, email, phone
    }
    
    init(with service: UserService) {
        self.service = service
    }
    
    @MainActor
    func loadPositions() async {
        if let loadedPositions = try? await service.loadPositions() {
            positions = loadedPositions
            selectedPositon = positions.randomElement()
        }
    }
    
    @MainActor
    func askForToken() async {
        if let serverToken = try? await service.getToken() {
            token = serverToken
        }
    }
    
    @MainActor
    func createUser(_ image: Data) async -> Bool {
        guard let positionID = selectedPositon?.id,
              !token.isEmpty else { return false }
        let user = UserNew(name: name, email: email, phone: phone, positionID: positionID, photo: image)
        return await service.uploadProfile(user: user, token: token)
    }
    
    var allFieldsAreValid: Bool {
        return isNameValid && isEmailValid && isPhoneValid
    }
    
    var isNameValid: Bool {
        let minLength = 2
        let maxLength = 60
        return name.count >= minLength && name.count <= maxLength
    }
    
    var isEmailValid: Bool {
        let minLength = 6
        let maxLength = 100
        guard email.count >= minLength && email.count <= maxLength else { return false }
        return email.range(of: Pattern.email, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var isPhoneValid: Bool {
        return phone.range(of: Pattern.phone, options: .regularExpression) != nil
    }
}
