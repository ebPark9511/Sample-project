//
//  NetworkManger.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/15.
//

import Foundation

import RxSwift

class NetworkManger: NetworkManagerType {
    
    var session: URLSession
    
    required init(session: URLSession) {
        self.session = session
    }
    
    func reqeust<T: ResponseType>(_ request: ReqeustType,
                                  of responseType: T.Type) -> Single<T> {
        
        return Single<T>.create { single in

            guard let request = request.request else {
                single(.failure(NetworkError.wrongRequest))
                return Disposables.create()
            }

            let task = self.session.dataTask(with: request) { data, response, error in

                guard let response = response as? HTTPURLResponse,
                      (200...399).contains(response.statusCode) else {

                    single(.failure(error ?? NetworkError.invalidResponse))
                    return
                }

                if let data = data,
                   let decoded = try? JSONDecoder().decode(T.self, from: data) {
                    single(.success(decoded))
                    return
                }

                single(.failure(error ?? NetworkError.invalidData))

            }

            task.resume()

            return Disposables.create(with: {
                task.cancel()
            })

        }
        
        
    }
    
}
