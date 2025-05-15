import SwiftUI

extension AnyTransition {
    static var slideBack: AnyTransition {
        .asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top))
    }
}
