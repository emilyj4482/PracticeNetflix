//
//  MainViewModel.swift
//  PracticeNetflix
//
//  Created by EMILY on 26/12/2024.
//

import Foundation
import RxSwift

// 넷플릭스 앱의 핵심 비즈니스 로직 : 서버로부터 영화 정보를 불러오는 것
class MainViewModel {
    
    private let disposeBag = DisposeBag()
    private let networkManager = NetworkManager.shared
    
    // view가 구독할 Observable
    let popularMovieSubject = BehaviorSubject(value: [Movie]())
    let topRatedMovieSubject = BehaviorSubject(value: [Movie]())
    let upcomingMovieSubject = BehaviorSubject(value: [Movie]())
    
    init() {
        fetchPopularMovies()
        fetchTopRatedMovies()
        fetchUpcomingMovies()
    }
    
    func fetchPopularMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKey.key)") else {
            popularMovieSubject.onError(NetworkError.invalidURL)
            return
        }
        
        networkManager.fetch(url: url)
            .subscribe(
                onSuccess: { [weak self] (movieResponse: MovieResponse) in
                    self?.popularMovieSubject.onNext(movieResponse.results)
                    
                },
                onFailure: { [weak self] error in
                    self?.popularMovieSubject.onError(error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func fetchTopRatedMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(APIKey.key)") else {
            topRatedMovieSubject.onError(NetworkError.invalidURL)
            return
        }
        
        networkManager.fetch(url: url)
            .subscribe(
                onSuccess: { [weak self] (movieResponse: MovieResponse) in
                    self?.topRatedMovieSubject.onNext(movieResponse.results)
                    
                },
                onFailure: { [weak self] error in
                    self?.topRatedMovieSubject.onError(error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func fetchUpcomingMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(APIKey.key)") else {
            upcomingMovieSubject.onError(NetworkError.invalidURL)
            return
        }
        
        networkManager.fetch(url: url)
            .subscribe(
                onSuccess: { [weak self] (movieResponse: MovieResponse) in
                    self?.upcomingMovieSubject.onNext(movieResponse.results)
                    
                },
                onFailure: { [weak self] error in
                    self?.upcomingMovieSubject.onError(error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func fetchTrailerKey(movie: Movie) -> Single<String> {
        let urlString = "https://api.themoviedb.org/3/movie/\(movie.id)/videos?api_key=\(APIKey.key)"
        
        guard let url = URL(string: urlString) else {
            return Single.error(NetworkError.invalidURL)
        }
        
        return networkManager.fetch(url: url)
            .flatMap { (response: VideoResponse) in
                if let trailer = response.results.first(where: { $0.type == "Trailer" && $0.site == "YouTube" }) {
                    guard let key = trailer.key else { return Single.error(NetworkError.dataFetchFail) }
                    return Single.just(key)
                } else {
                    return Single.error(NetworkError.dataFetchFail)
                }
            }
    }
}
