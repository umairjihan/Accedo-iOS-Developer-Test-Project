//
//  MovieListViewModel.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import Foundation
import Combine

protocol MovieListViewModelInput: ObservableObject {
    func fetchMovies()
    func didLoadNextPage()
    func shouldFetchNextPage(item : MovieListItemViewModel) -> Bool
}

protocol MovieListViewModelOutput: ObservableObject {
    var items :[MovieListItemViewModel] {get}
}

class MovieListViewModel: MovieListViewModelOutput, MovieListViewModelInput, MovieFlowStateProtocol {
    
    @Published var items : [MovieListItemViewModel] = []
    
    @Published var activeLink: MovieLink?
    
    private let usecase: FetchMoviesUseCase!
    
    private var observer: AnyCancellable? = nil
    
    var page: Int
    
    private var isLoading: Bool = false
    
    private var totalPages: Int = 0
    
    var currentCount: Int {
        get {
            return items.count
        }
    }
    
    init(usecase: FetchMoviesUseCase) {
        self.usecase = usecase
        self.page = usecase.page
    }
    
    
    func shouldFetchNextPage(item : MovieListItemViewModel) -> Bool{
        return !isLoading && page < totalPages && item.id == self.items.last?.id
    }
    
    func fetchMovies(){
        self.isLoading = true
        self.observer = self.usecase.start().sink (  receiveCompletion:{  [weak self] completion in
            switch completion {
            case .finished:
                print("Finished calling")
            case .failure(let error):
                print("Error calling \(error)")
            }
            self?.isLoading = false
        }, receiveValue: { [weak self] response in
            guard let `self` = self, let movies = response as? MovieList else { return }
            let items = movies.results.map { movie in
                return MovieListItemViewModel(id: movie.id, movietitle: movie.title, imagePath: movie.posterPath)
            }
            self.items.append(contentsOf: items)
            self.page = movies.page
            self.totalPages = movies.totalPages
        })
    }
    
    
    func didLoadNextPage() {
        self.usecase.page = self.page + 1
        self.isLoading = true
        self.observer = self.usecase.start().sink ( receiveCompletion:{  [weak self] completion in
            switch completion {
            case .finished:
                print("Finished calling")
            case .failure(let error):
                print("Error calling \(error)")
            }
            self?.isLoading = false
        }, receiveValue: { [weak self] response in
            guard let `self` = self, let movies = response as? MovieList else { return }
            let items = movies.results.map { movie in
                return MovieListItemViewModel(id: movie.id, movietitle: movie.title, imagePath: movie.posterPath)
            }
            self.items.append(contentsOf: items)
            self.page = movies.page
            self.totalPages = movies.totalPages
        })
    }
}
