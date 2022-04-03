//
//  FetchMoviesUseCase.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import Foundation
import Combine

class FetchMoviesUseCase: UseCase {
    
    private let repository: MovieRepository
    var page: Int
    private let genre: Int
    
    init(repository: MovieRepository, page: Int = 1, genre: Int) {
        self.repository = repository
        self.page = page
        self.genre = genre
    }
    
    
    func start() -> Future<Response?,ErrorResponse> {
        Future { [weak self] promise in
            self?.repository.getMovieList(page: self?.page ?? 0, genre: self?.genre ?? 0, completion: { result, error in
                if result != nil {
                    if let data = result as? MovieList {
                        promise(Result.success(data))
                    }
                }else {
                    promise(Result.failure(error!))
                }
            })
        }
    }
    
}
