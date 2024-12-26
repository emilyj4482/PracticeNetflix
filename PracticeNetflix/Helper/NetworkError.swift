//
//  NetworkError.swift
//  PracticeNetflix
//
//  Created by EMILY on 26/12/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case dataFetchFail
    case decodingFail
}
