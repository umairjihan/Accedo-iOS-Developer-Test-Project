//
//  Environment.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

public enum Environment {
    case dev
    case prod
    
    var baseURL: String {
        switch self {
        case .dev:
            return "api.themoviedb.org"
        case .prod:
            return "api.themoviedb.org"
       
        }
    }
    
    var imageBaseURL: String {
        switch self {
        case .dev:
            return "https://image.tmdb.org/t/p/w200"
        case .prod:
            return "https://image.tmdb.org/t/p/w200"
       
        }
    }
    
}
