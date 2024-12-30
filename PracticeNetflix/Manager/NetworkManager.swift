//
//  NetworkManager.swift
//  PracticeNetflix
//
//  Created by EMILY on 26/12/2024.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        return Future { promise in
            let session = URLSession(configuration: .default)
            session.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                guard
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    (200..<300).contains(response.statusCode)
                else {
                    promise(.failure(NetworkError.dataFetchFail))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    promise(.success(decodedData))
                } catch {
                    promise(.failure(NetworkError.decodingFail))
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
}
