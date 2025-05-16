import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tab = .users
    private let service = UserService()
    
    private enum Tab: CaseIterable {
        case users, signUp
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: header(for: selectedTab))
            tabPage.frame(maxHeight: .infinity)
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    barButton(for: tab)
                }
            }
        }
        .background(.customBackground)
    }
}

#Preview {
    HomeView()
}

private extension HomeView {
    private func barButton(for tab: Tab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            HStack(spacing: 8) {
                Image(systemName: icon(for: tab))
                    .resizable()
                    .scaledToFit()
                    .setHeight(22)
                Text(title(for: tab))
                    .font(.nunito(style: .semiBold, size: 16))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16 * Screen.scaleFactor)
            .foregroundStyle(selectedTab == tab ? .customSecondary : .black.opacity(0.6))
            .background(.customTabBar)
        }
    }
    
    @ViewBuilder
    var tabPage: some View {
        switch selectedTab {
        case .users:
            UsersView(service: service)
        case .signUp:
            SignUpView(service: service)
        }
    }
    
    private func title(for tab: Tab) -> String {
        switch tab {
        case .users:
            return LocalizedText.TabBar.users
        case .signUp:
            return LocalizedText.TabBar.signUp
        }
    }
    
    private func header(for tab: Tab) -> String {
        switch tab {
        case .users:
            return LocalizedText.TopBar.reguestGETTitle
        case .signUp:
            return LocalizedText.TopBar.reguestPOSTTitle
        }
    }
    
    private func icon(for tab: Tab) -> String {
        switch tab {
        case .users:
            IconNames.users.rawValue
        case .signUp:
            IconNames.signUp.rawValue
        }
    }
}
