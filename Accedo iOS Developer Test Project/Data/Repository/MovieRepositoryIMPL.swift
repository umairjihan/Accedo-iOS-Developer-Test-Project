//
//  MovieRepositoryIMPL.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import Foundation

final class MovieRepositoryIMPL {

    private let remoteDateSource: MovieDataSource
    
    init(remote: MovieDataSource) {
        self.remoteDateSource = remote
    }
}

extension MovieRepositoryIMPL: MovieRepository{
    
    func getMovieList(page: Int, genre: Int, completion: @escaping (_ result: Response?, _ error: ErrorResponse?) -> Void) {
        let args = MovieListArgs(page: page, api_key: Constants.apiKey, with_genres: genre)
        remoteDateSource.getMovieList(movieListArgs: args, completion: completion)
    }
    
}
