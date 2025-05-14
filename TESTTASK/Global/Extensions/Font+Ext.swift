import SwiftUI

extension Font {
    static func nunito(style: NunitoSansStyle = .regular, size: CGFloat) -> Font {
        let fontSize = size * Screen.scaleFactor
        
        switch style {
        case .regular:
            return .custom("NunitoSans-Regular", fixedSize: fontSize)
        case .semiBold:
            return .custom("NunitoSans-SemiBold", fixedSize: fontSize)
        }
    }
    
    enum NunitoSansStyle {
        case regular, semiBold
    }
}
