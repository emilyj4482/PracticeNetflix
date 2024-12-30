//
//  MainViewModel.swift
//  PracticeNetflix
//
//  Created by EMILY on 26/12/2024.
//

import Foundation
import Combine

// 넷플릭스 앱의 핵심 비즈니스 로직 : 서버로부터 영화 정보를 불러오는 것
class MainViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager.shared
    
    let popularMovieSubject = CurrentValueSubject<[Movie], Error>([])
    let topRatedMovieSubject = CurrentValueSubject<[Movie], Error>([])
    let upcomingMovieSubject = CurrentValueSubject<[Movie], Error>([])
    
    func fetch() {
        fetchPopularMovies()
        fetchTopRatedMovies()
        fetchUpcomingMovies()
    }
    
    private func fetchPopularMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKey.key)") else {
            popularMovieSubject.send(completion: .failure(NetworkError.invalidURL))
            return
        }
        
        networkManager.fetch(url: url)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.popularMovieSubject.send(completion: .failure(error))
                case .finished:
                    self?.popularMovieSubject.send(completion: .finished)
                }
            } receiveValue: { [weak self] (movieResponse: MovieResponse) in
                self?.popularMovieSubject.send(movieResponse.results)
            }
            .store(in: &cancellables)
    }
    
    private func fetchTopRatedMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(APIKey.key)") else {
            topRatedMovieSubject.send(completion: .failure(NetworkError.invalidURL))
            return
        }
        
        networkManager.fetch(url: url)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.topRatedMovieSubject.send(completion: .failure(error))
                case .finished:
                    self?.topRatedMovieSubject.send(completion: .finished)
                }
            } receiveValue: { [weak self] (movieResponse: MovieResponse) in
                self?.topRatedMovieSubject.send(movieResponse.results)
            }
            .store(in: &cancellables)
    }
    
    private func fetchUpcomingMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(APIKey.key)") else {
            upcomingMovieSubject.send(completion: .failure(NetworkError.invalidURL))
            return
        }
        
        networkManager.fetch(url: url)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.upcomingMovieSubject.send(completion: .failure(error))
                case .finished:
                    self?.upcomingMovieSubject.send(completion: .finished)
                }
            } receiveValue: { [weak self] (movieResponse: MovieResponse) in
                self?.upcomingMovieSubject.send(movieResponse.results)
            }
            .store(in: &cancellables)
    }
    
    func fetchTrailerKey(movie: Movie) -> AnyPublisher<String, Error> {
        let urlString = "https://api.themoviedb.org/3/movie/\(movie.id)/videos?api_key=\(APIKey.key)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return Future<String, Error> { [weak self] promise in
            guard let self = self else { return }
            networkManager.fetch(url: url)
                .sink (
                    receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            promise(.failure(error))
                        }
                    },
                    receiveValue: { (videoResponse: VideoResponse) in
                        if let trailer = videoResponse.results.first(where: { $0.type == "Trailer" && $0.site == "YouTube" }),
                           let key = trailer.key {
                            promise(.success(key))
                        } else {
                            promise(.failure(NetworkError.dataFetchFail))
                        }
                    }
                )
                .store(in: &cancellables)
        }
        .eraseToAnyPublisher()
    }
}
