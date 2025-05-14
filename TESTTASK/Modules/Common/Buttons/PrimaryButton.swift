import SwiftUI

struct PrimaryButton: View {
    let title: String
    let disabled: Bool
    let customAction: () -> ()
    
    init(_ title: String, disabled: Bool, action: @escaping () -> Void) {
        self.title = title
        self.disabled = disabled
        self.customAction = action
    }
    
    var body: some View {
        let custom = CustomStyle(isDisabled: disabled)
        
        Button(title, action: customAction)
            .buttonStyle(custom)
            .disabled(disabled)
    }
}

#Preview {
    PrimaryButton(LocalizedText.Button.sighUp, disabled: false) { }
}

fileprivate struct CustomStyle: ButtonStyle {
    let isDisabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = defineBackgroundColor(for: configuration)
        
        configuration.label
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .padding(.horizontal)
            .foregroundStyle(.black)
            .font(.nunito(style: .semiBold, size: 18))
            .opacity(isDisabled ? 0.48 : 0.87)
            .background(backgroundColor)
            .corners(radius: 24)
    }
    
    private func defineBackgroundColor(for configuration: Configuration) -> Color {
        if isDisabled {
            return Color.customGray
        } else {
            return configuration.isPressed ? .customOrange : .customPrimary
        }
    }
}
