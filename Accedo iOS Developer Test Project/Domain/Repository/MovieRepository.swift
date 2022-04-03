//
//  MovieRepository.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import Foundation

protocol MovieRepository {
    
    func getMovieList(page: Int, genre: Int, completion: @escaping (_ result: Response?, _ error: ErrorResponse?) -> Void)
    
}
