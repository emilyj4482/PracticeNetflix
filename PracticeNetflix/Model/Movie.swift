//
//  Movie.swift
//  PracticeNetflix
//
//  Created by EMILY on 25/12/2024.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
    }
}
