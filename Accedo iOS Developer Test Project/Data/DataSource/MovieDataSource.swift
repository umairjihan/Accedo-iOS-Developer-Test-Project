//
//  MovieDataSource.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import Foundation

protocol MovieDataSource {
 
    func getMovieList( movieListArgs: MovieListArgs, completion: @escaping (_ result: MovieList?, _ error: ErrorResponse?) -> Void)
    
}
