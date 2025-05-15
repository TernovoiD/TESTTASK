import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel: SignUpViewModel
    
    init(service: UserService) {
        let viewModel = SignUpViewModel(with: service)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SignUpView(service: UserService())
}
