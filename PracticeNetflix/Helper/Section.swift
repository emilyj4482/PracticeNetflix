//
//  Section.swift
//  PracticeNetflix
//
//  Created by EMILY on 26/12/2024.
//

import Foundation

enum Section: Int, CaseIterable {
    case popular
    case topRated
    case upcoming
    
    var title: String {
        switch self {
        case .popular:
            "이 시간 핫한 영화"
        case .topRated:
            "가장 평점이 높은 영화"
        case .upcoming:
            "곧 개봉되는 영화"
        }
    }
}
