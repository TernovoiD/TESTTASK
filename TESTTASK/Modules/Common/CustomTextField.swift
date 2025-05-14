import SwiftUI

struct CustomTextField: View {
    @FocusState private var isFocused: Bool
    @State var text = ""
    
    
    var body: some View {
        let customStyle = CustomStyle(labelText: LocalizedText.TextField.name, supportingText: "", isEmpty: text.isEmpty, state: isFocused ? .focused : .normal)
        
        TextField("", text: $text.animation(.easeInOut))
            .textFieldStyle(customStyle)
            .focused($isFocused)
            .font(.nunito(size: 14))
            .padding()
            .background(.customBackground)
            .onTapGesture { isFocused.toggle() }
            .animation(.spring, value: isFocused)
            .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    CustomTextField()
}

fileprivate struct CustomStyle: TextFieldStyle {
    let labelText: String
    let supportingText: String
    let isEmpty: Bool
    let state: State
    private let height = 48 * Screen.scaleFactor
    private let spaceFactor = 1.65
    
    enum State {
        case normal, focused, error
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    titleLabel.setHeight(height)
                    VStack(spacing: 0) {
                        if isTitleShifted { Spacer() }
                        configuration
                            .setHeight(isTitleShifted ? height / spaceFactor : height)
                            .tint(.gray)
                    }
                }
            }
            .setHeight(height)
            .padding(.leading, 10)
            .padding(.vertical, 4)
            .overlay { lineOverlay }
            supportingLabel
        }
    }
    
    private var isTitleShifted: Bool { !isEmpty || state == .focused }
    
    private var titleLabel: some View {
        VStack(spacing: 0) {
            Text(labelText)
                .font(.nunito(size: isTitleShifted ? 12 : 15))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(lableColor)
                .setHeight(height / spaceFactor)
            if isTitleShifted { Spacer() }
        }
    }
    
    private var supportingLabel: some View {
        Text(supportingText)
            .font(.nunito(size: 12))
            .foregroundStyle(state == .error ? .customRed : .black.opacity(0.6))
            .padding(.leading, 10)
    }
    
    private var lineOverlay: some View {
        let width: CGFloat = state == .focused ? 2 : 1
        
        return RoundedRectangle(cornerRadius:4, style: .continuous)
            .stroke(lineColor, lineWidth: width)
    }
    
    private var lineColor: Color {
        switch state {
        case .normal:
            return .customGray
        case .focused:
            return .customSecondary
        case .error:
            return .customRed
        }
    }
    
    private var lableColor: Color {
        switch state {
        case .normal:
            return .black.opacity(0.48)
        case .focused:
            return isEmpty ? .customSecondary : .customPurple
        case .error:
            return .customRed
        }
    }
}
