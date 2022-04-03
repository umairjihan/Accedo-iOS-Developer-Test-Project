//
//  FetchGenresUseCase.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation
import Combine

class FetchGenresUseCase: UseCase {
    
    private let repository: GenreRepository

    init(repository: GenreRepository) {
        self.repository = repository
    }
    
    
    func start() -> Future<Response?,ErrorResponse> {
        Future { [weak self] promise in
            self?.repository.getGenreList(completion: { result, error in
                if result != nil {
                    if let data = result as? GenreList {
                        promise(Result.success(data))
                    }
                }else {
                    promise(Result.failure(error!))
                }
            })
            
        }
    }
    
}
