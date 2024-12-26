//
//  MainViewModel.swift
//  PracticeNetflix
//
//  Created by EMILY on 26/12/2024.
//

import Foundation

// 넷플릭스 앱의 핵심 비즈니스 로직 : 서버로부터 영화 정보를 불러오는 것
class MainViewModel {
    
    private let networkManager = NetworkManager.shared
    
    init() {
        fetchPopularMovies()
        fetchTopRatedMovies()
        fetchUpcomingMovies()
    }
    
    func fetchPopularMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKey.key)") else {
            // subject.onError
            return
        }
    }
    
    func fetchTopRatedMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(APIKey.key)") else {
            // subject.onError
            return
        }
    }
    
    func fetchUpcomingMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(APIKey.key)") else {
            // subject.onError
            return
        }
    }
    
    // TODO: fetchTrailerKey(movie: Movie) -> Single<String>
    // let urlString = "https://api.themoviedb.org/3/movie/\(movie.id)/videos?api_key=\(APIKey.key)"
}
