import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel: UsersViewModel
    
    init(service: UserService) {
        let viewModel = UsersViewModel(with: service)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if viewModel.users.isEmpty { EmptyUsersView() } else { usersList }
        }
        .transition(.slideBack)
        .animation(viewModel.users.count <= 6 ? .bouncy : nil, value: viewModel.users)
#warning("Call is turned off")
//        .task { await viewModel.loadUsers() }
    }
    
    private func loadNextPage() {
        Task { await viewModel.nextPage() }
    }
}

#Preview {
    UsersView(service: UserService())
}

private extension UsersView {
    var usersList: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.users) { user in
                    let lastUser = viewModel.users.last
                    let lastInList = user.id == lastUser?.id
                    let addLine = !lastInList
                    row(for: user, line: addLine)
                    
                    if lastInList && !viewModel.lastPage {
                        ProgressView().onAppear { loadNextPage() }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    func row(for user: User, line: Bool) -> some View {
        HStack(alignment: .top, spacing: 16) {
            Image(.avatar)
                .resizable()
                .scaledToFit()
                .setHeight(50)
            info(for: user, line: line)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.nunito(size: 14))
                .opacity(0.87)
        }
        .padding(.top, 24)
    }
    
    func info(for user: User, line: Bool) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(user.name)
                .font(.nunito(size: 18))
                .lineLimit(3)
            Text(user.position)
                .opacity(0.6)
                .padding(.top, 4)
                .padding(.bottom, 8)
                .lineLimit(1)
            Text(user.email)
                .padding(.bottom, 4)
                .lineLimit(1)
            Text(user.phone)
                .padding(.bottom, 4)
                .lineLimit(1)
                .padding(.bottom, 24)
            if line { Divider() }
        }
    }
}
