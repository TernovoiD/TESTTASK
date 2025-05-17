import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel: SignUpViewModel
    @EnvironmentObject private var router: AppRouter
    @FocusState private var focusedField: SignUpViewModel.Field?
    @State private var image: UIImage?
    
    init(service: UserService) {
        let viewModel = SignUpViewModel(with: service)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                let isFormReady = image != nil && viewModel.allFieldsAreValid
                textFields.font(.nunito(size: 14))
                if !viewModel.positions.isEmpty { positionSelector }
                ImageLoader(image: $image)
                PrimaryButton(LocalizedText.Button.sighUp, disabled: !isFormReady, action: uploadNewUser)
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
        }
        .foregroundStyle(.black.opacity(0.87))
        .animation(.spring, value: focusedField)
        .animation(.easeInOut, value: viewModel.positions)
        .background(.customBackground)
        .onTapGesture { focusedField = .none }
        .task {
            await viewModel.loadPositions()
            await viewModel.askForToken()
        }
    }
    
    private func uploadNewUser() {
        guard let image,
              let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        Task {
            let result = await viewModel.createUser(imageData)
            router.current = .registerSuccess(result)
        }
    }
    
    private func select(_ position: Position) {
        withAnimation(.easeInOut) {
            focusedField = .none
            viewModel.selectedPositon = position
        }
    }
}

#Preview {
    SignUpView(service: UserService())
        .environmentObject(AppRouter(current: .home))
}

private extension SignUpView {
    var textFields: some View {
        VStack(spacing: 32) {
            nameField
            emailField
            phoneField
        }
    }
    
    var positionSelector: some View {
        VStack(spacing: 12) {
            Text(LocalizedText.selectPosition)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.nunito(size: 18))
            ForEach(viewModel.positions) { position in
                radioButton(for: position)
                    .setHeight(48)
                    .onTapGesture { select(position) }
            }
        }
    }
    
    var nameField: some View {
        let check = stateCheck(for: .name, text: viewModel.name, isValid: viewModel.isNameValid)
        let style = CustomTFStyle(labelText: LocalizedText.TextField.name,
                                  supportingText: check == .error ? LocalizedText.TextField.requiredField : "",
                                  isEmpty: viewModel.name.isEmpty,
                                  state: check)
        return TextField("", text: $viewModel.name)
            .focused($focusedField, equals: .name)
            .textFieldStyle(style)
    }
    
    var emailField: some View {
        let check = stateCheck(for: .email, text: viewModel.email, isValid: viewModel.isEmailValid)
        let style = CustomTFStyle(labelText: LocalizedText.TextField.email,
                                  supportingText: check == .error ? LocalizedText.TextField.invalidEmail : "",
                                  isEmpty: viewModel.email.isEmpty,
                                  state: check)
        return TextField("", text: $viewModel.email)
            .focused($focusedField, equals: .email)
            .textFieldStyle(style)
    }
    
    var phoneField: some View {
        let check = stateCheck(for: .phone, text: viewModel.phone, isValid: viewModel.isPhoneValid)
        let style = CustomTFStyle(labelText: LocalizedText.TextField.phone,
                                  supportingText: check == .error ? LocalizedText.TextField.requiredField : "",
                                  isEmpty: viewModel.phone.isEmpty,
                                  state: check)
        return TextField("", text: $viewModel.phone)
            .focused($focusedField, equals: .phone)
            .textFieldStyle(style)
    }
    
    func stateCheck(for field: SignUpViewModel.Field, text: String, isValid: Bool) -> CustomTFStyle.State {
        if focusedField == field {
            return .focused
        } else if !text.isEmpty && !isValid {
            return .error
        } else { return .normal }
    }
    
    func radioButton(for position: Position) -> some View {
        HStack(spacing: 8) {
            Image(position == viewModel.selectedPositon ? .radioButtonSelected : .radioButton)
                .resizable()
                .scaledToFit()
                .setHeight(48)
            Text(position.name)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
