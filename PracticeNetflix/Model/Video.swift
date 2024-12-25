//
//  Video.swift
//  PracticeNetflix
//
//  Created by EMILY on 25/12/2024.
//

import Foundation

struct VideoResponse: Codable {
    let results: [Video]
}

struct Video: Codable {
    let key: String?
    let site: String?
    let type: String?
}
