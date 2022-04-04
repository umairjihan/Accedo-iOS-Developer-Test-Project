//
//  GenreList.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

// MARK: - GenreList
struct GenreList: Response {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

struct WorldTime: Codable {
    let year, month, day, hour: Int
    let minute, seconds, milliSeconds: Int
    let dateTime, date, time, timeZone: String
    let dayOfWeek: String
    let dstActive: Bool
}

