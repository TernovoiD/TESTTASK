import SwiftUI

struct SetWidthModifier: ViewModifier {
    let width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width * Screen.scaleFactor)
    }
}

extension View {
    func setWidth(_ width: CGFloat) -> some View {
        return self.modifier(SetWidthModifier(width: width))
    }
}
