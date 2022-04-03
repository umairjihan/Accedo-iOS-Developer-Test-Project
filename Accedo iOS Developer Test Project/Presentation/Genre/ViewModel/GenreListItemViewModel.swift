//
//  GenreListItemViewModel.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

protocol GenreListItemViewModelOutput{
    var id: Int { get }
    var name: String { get }
}

class GenreListItemViewModel {
    let id: Int
    let name: String
    
    init(id: Int, name:String){
        self.id = id
        self.name = name
    }
}
