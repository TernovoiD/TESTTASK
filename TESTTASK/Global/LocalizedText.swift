import Foundation

struct LocalizedText {
    static let noConnection = String(localized: "There is no internet connection")
    static let noUsers = String(localized: "There are no users yet")
    static let uploadPhoto = String(localized: "Upload your photo")
    static let choosePhoto = String(localized: "Choose how you want to add a photo")
    static let registerSuccess = String(localized: "User successfully registered")
    static let registerFailure = String(localized: "That email is already registered")
    static let selectPosition = String(localized: "Select your position")
    
    struct TextField {
        static let name = String(localized: "Your name")
        static let email = String(localized: "Email")
        static let phone = String(localized: "Phone")
        static let phoneExample = String(localized: "+38 (XXX) XXX - XX - XX")
        
        
        static let requiredField = String(localized: "Required field")
        static let invalidEmail = String(localized: "Invalid email format")
    }
    
    struct Button {
        static let gotIt = String(localized: "Got it")
        static let sighUp = String(localized: "Sign up")
        static let tryAgain = String(localized: "Try again")
        static let upload = String(localized: "Upload")
    }
    
    struct TabBar {
        static let users = String(localized: "Users")
        static let signUp = String(localized: "Sign up")
    }
    
    struct TopBar {
        static let reguestGETTitle = String(localized: "Working with GET request")
        static let reguestPOSTTitle = String(localized: "Working with POST request")
    }
}
