import SwiftUI

struct Screen {
    static var scaleFactor: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let originalDesignWidth: CGFloat = 393.0
        let scaledWidth = screenWidth / originalDesignWidth
        
        let screenHeight = UIScreen.main.bounds.height
        let originalDesignHeight: CGFloat = 852.0
        let scaledHeight =  screenHeight / originalDesignHeight
        
        return min(scaledWidth, scaledHeight)
    }
}
