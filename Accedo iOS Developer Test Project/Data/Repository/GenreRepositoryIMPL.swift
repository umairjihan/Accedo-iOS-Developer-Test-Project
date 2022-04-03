//
//  GenreRepositoryIMPL.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

final class GenreRepositoryIMPL {

    private let remoteDateSource: GenreDataSource
    
    init(remote: GenreDataSource) {
        self.remoteDateSource = remote
    }
}

extension GenreRepositoryIMPL: GenreRepository{
    
    func getGenreList(completion: @escaping (_ result: Response?, _ error: ErrorResponse?) -> Void) {
        let args = GenreListArgs(api_key: Constants.apiKey)
        remoteDateSource.getGenreList(genreListArgs: args, completion: completion)
    }
    
}
