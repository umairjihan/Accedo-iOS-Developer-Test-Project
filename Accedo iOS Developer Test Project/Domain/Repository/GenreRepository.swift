//
//  GenreRepository.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

protocol GenreRepository {
    
    func getGenreList(completion: @escaping (_ result: Response?, _ error: ErrorResponse?) -> Void)
    
}
