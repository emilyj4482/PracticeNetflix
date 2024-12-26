//
//  NetworkManager.swift
//  PracticeNetflix
//
//  Created by EMILY on 26/12/2024.
//

import Foundation
import RxSwift

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // 어떤 T 타입의 Single을 반환할 지는 모르지만, T는 Decodable을 만족하는 타입이어야 한다.
    func fetch<T: Decodable>(url: URL) -> Single<T> {
        return Single.create { observer in
            let session = URLSession(configuration: .default)
            session.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                
                guard
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    (200..<300).contains(response.statusCode)
                else {
                    observer(.failure(NetworkError.dataFetchFail))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    // Single에 success 방출
                    observer(.success(decodedData))
                } catch {
                    observer(.failure(NetworkError.decodingFail))
                }
            }.resume()
            
            return Disposables.create()
        }
    }
}
