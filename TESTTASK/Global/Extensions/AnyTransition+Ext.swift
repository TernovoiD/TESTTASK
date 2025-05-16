import SwiftUI

extension AnyTransition {
    static var slideBack: AnyTransition {
        .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    }
}
