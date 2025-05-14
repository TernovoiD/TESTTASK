import SwiftUI

struct CornerModifier: ViewModifier {
    let radius: CGFloat
    
    private var cornersShape: RoundedRectangle {
        let scaledRadius = radius * Screen.scaleFactor
        return RoundedRectangle(cornerRadius: scaledRadius, style: .continuous)
    }
    
    func body(content: Content) -> some View {
        content
            .clipShape(cornersShape)
    }
}

extension View {
    func corners(radius: CGFloat) -> some View {
        return self.modifier(CornerModifier(radius: radius))
    }
}
