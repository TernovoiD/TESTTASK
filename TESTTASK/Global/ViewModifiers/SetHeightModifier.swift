import SwiftUI

struct SetHeightModifier: ViewModifier {
    let height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(height: height * Screen.scaleFactor)
    }
}

extension View {
    func setHeight(_ height: CGFloat) -> some View {
        return self.modifier(SetHeightModifier(height: height))
    }
}
