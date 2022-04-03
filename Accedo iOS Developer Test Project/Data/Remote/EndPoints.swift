//
//  EndPoints.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation
struct EndPoints {
    static let endPointVersion = "/3"
    
 
    ///Holdinh all APIs for car types
    struct Tmbd {
        ///we should add the name of the controller here
        ///for now we don't have controller name
        static let endPointController = "/"
        
        static var movieGenre: String { get {  return "\(endPointVersion)\(endPointController)genre/movie/list" }  }
        
        static var discoverMovie: String { get {  return "\(endPointVersion)\(endPointController)discover/movie" }  }
    }
}
