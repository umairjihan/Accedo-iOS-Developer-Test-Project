//
//  GenreListViewModel.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation
import Combine

protocol GenreListViewModelInput: ObservableObject {
    func didSelect(item: GenreListItemViewModel)
    func fetchGenres()
}

protocol GenreListViewModelOutput: ObservableObject {
    var items :[GenreListItemViewModel] {get}
}


class GenreListViewModel: GenreListViewModelInput, GenreListViewModelOutput, GenreFlowStateProtocol {
   
    @Published var items: [GenreListItemViewModel] = []
    @Published var activeLink: GenreLink?
    
    private let usecase: FetchGenresUseCase!
    
    private var observer: AnyCancellable? = nil
    
    init(usecase: FetchGenresUseCase) {
        self.usecase = usecase
    }
    
    func fetchGenres(){
        self.observer = self.usecase.start().sink ( receiveCompletion:{ completion in
            switch completion {
            case .finished:
                print("Finished calling")
            case .failure(let error):
                print("Error calling \(error)")
            }
        }, receiveValue: { [weak self] response in
            guard let `self` = self, let genres = response as? GenreList else { return }
            self.items = genres.genres.map { genre in
                return GenreListItemViewModel(id: genre.id, name: genre.name)
            }
        })
    }
    
    func didSelect(item: GenreListItemViewModel) {
        activeLink = .movieLinkParametrized(genreId: item.id)
    }
    
}


