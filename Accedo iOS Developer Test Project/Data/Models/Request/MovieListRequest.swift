//
//  MovieListRequest.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

struct MovieListArgs: APIKey, Codable {
    var page: Int
    var api_key: String
    var with_genres: Int
}
