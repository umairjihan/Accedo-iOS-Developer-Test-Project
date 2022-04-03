//
//  GenreListView.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import SwiftUI

struct GenreListView<VM: GenreListViewModelInput & GenreListViewModelOutput & GenreFlowStateProtocol>: View {
    
    @StateObject var viewModel: VM

    var body: some View {
        GenreFlowCoordinator(state: viewModel, content: content)
    }
    
    @ViewBuilder private func content() -> some View {
        List(viewModel.items, id: \.id) { item in
            Button(item.name) {
                viewModel.didSelect(item: item)
            }
        }.task {
            viewModel.fetchGenres()
        }
        #if os(iOS)
        .navigationBarTitle("Tmdb", displayMode: .inline)
        #endif
    }
}

//struct GenreListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let repository = GenreRepositoryIMPL(remote: GenreRemoteService())
//        let useCase = FetchGenresUseCase(repository: repository)
//        let viewModel = GenreListViewModel(usecase: useCase)
//        GenreListView(viewModel: viewModel)
//    }
//}
