//
//  MovieListItemViewModel.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import Foundation

protocol MovieListItemViewModelOutput  {
    var id: Int { get }
    var imageUrl: URL { get }
    var movietitle: String { get }
}

class MovieListItemViewModel: MovieListItemViewModelOutput {
    
    let uniqueID = UUID()
    let id: Int
    let imageUrl: URL
    let movietitle: String
    
    init( id: Int, movietitle: String, imagePath: String){
        self.id = id
        self.movietitle = movietitle
        let env = AppEnvironment.current
        self.imageUrl = URL(string: "\(env.imageBaseURL)\(imagePath)")!
    }
}
