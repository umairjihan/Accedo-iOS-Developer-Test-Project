//
//  MovieListView.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import SwiftUI

struct MovieListView<VM: MovieListViewModelOutput & MovieListViewModelInput & MovieFlowStateProtocol>: View {
    
    @StateObject var viewModel: VM
    
    var columns: [GridItem] {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            return Array(repeating: GridItem(.flexible()), count: 2)
        }else{
            return Array(repeating: GridItem(.flexible()), count: 4)
        }
        
    }
    
    let height: CGFloat = 50
    
    var body: some View {
        MovieFlowCoordinator(state: viewModel, content: content)
    }
    
    @ViewBuilder private func content() -> some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                ForEach(viewModel.items, id: \.uniqueID) { item in
                    if viewModel.shouldFetchNextPage(item: item) {
                        MovieCellView(viewModel: item)
                            .frame(height: height)
                            .task {
                                self.viewModel.didLoadNextPage()
                            }
                    }else{
                        MovieCellView(viewModel: item)
                            .frame(height: height)
                    }
                }
            }.task {
                self.viewModel.fetchMovies()
            }
            .padding()
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = MovieRepositoryIMPL(remote: MovieRemoteService())
        let useCase = FetchMoviesUseCase(repository: repository, genre: 1)
        let viewModel = MovieListViewModel(usecase: useCase)
        MovieListView(viewModel: viewModel)
    }
}
