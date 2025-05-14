import SwiftUI

struct SecondaryButton: View {
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
    SecondaryButton(LocalizedText.Button.upload, disabled: false) { }
}

fileprivate struct CustomStyle: ButtonStyle {
    let isDisabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        let foregroundColor: Color = isDisabled ? .black.opacity(0.48) : .customSecondaryDark
        let backgroundColor = defineBackgroundColor(for: configuration)
        
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .foregroundStyle(foregroundColor)
            .font(.nunito(style: .semiBold, size: 16))
            .opacity(isDisabled ? 0.48 : 1)
            .background(backgroundColor)
            .corners(radius: 24)
    }
    
    private func defineBackgroundColor(for configuration: Configuration) -> Color {
        return configuration.isPressed ? .customSecondary.opacity(0.1) : .clear
    }
}
