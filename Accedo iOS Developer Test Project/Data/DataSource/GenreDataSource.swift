//
//  GenreDataSource.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

protocol GenreDataSource {
 
    func getGenreList( genreListArgs: GenreListArgs, completion: @escaping (_ result: GenreList?, _ error: ErrorResponse?) -> Void)
    
}
