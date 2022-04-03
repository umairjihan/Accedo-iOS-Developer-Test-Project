//
//  GenreFlowCoordinator.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import SwiftUI

protocol GenreFlowStateProtocol: ObservableObject {
    var activeLink: GenreLink? { get set }
}

enum GenreLink: Hashable, Identifiable {
    case movieLink
    case movieLinkParametrized(genreId: Int)

    var navigationLink: GenreLink {
        switch self {
        case .movieLinkParametrized:
            return .movieLink
        default:
            return self
        }
    }

    var id: String {
        switch self {
        case .movieLink, .movieLinkParametrized:
            return "movie"
        }
    }
}

struct GenreFlowCoordinator<State: GenreFlowStateProtocol, Content: View>: View {

    @ObservedObject var state: State
    let content: () -> Content

    private var activeLink: Binding<GenreLink?> {
        $state.activeLink.map(get: { $0?.navigationLink }, set: { $0 })
    }

    var body: some View {
        NavigationView {
            ZStack {
                content()
                navigationLinks
            }
        }
        .navigationViewStyle(.stack)
    }

    @ViewBuilder private var navigationLinks: some View {
        NavigationLink(tag: .movieLink, selection: activeLink, destination: movieDestination) { EmptyView() }
    }

    private func movieDestination() -> some View {
        var genreId: Int = 0
        if case let .movieLinkParametrized(param) = state.activeLink {
            genreId = param
        }

        let repository = MovieRepositoryIMPL(remote: MovieRemoteService())
        let useCase = FetchMoviesUseCase(repository: repository, genre: genreId)
        let viewModel = MovieListViewModel(usecase: useCase)
        let view = MovieListView(viewModel: viewModel)
        
        return view
    }

}

