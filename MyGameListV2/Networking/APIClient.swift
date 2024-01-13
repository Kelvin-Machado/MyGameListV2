//
//  APIClient.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/01/24.
//

import Foundation
import RxSwift
import Alamofire

class APIClient {
    static let shared = APIClient()

    private let baseURL = "https://api.rawg.io/api/"
    private let session = URLSession.shared

    func send<T: Decodable>(_ request: APIRequest<T>) -> Observable<T> {
        guard let urlRequest = request.urlRequest(withBaseURL: baseURL) else {
            return Observable.error(APIError.invalidURL)
        }

        return session.rx.data(request: urlRequest)
            .map { data in
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    print(result)
                    return result
                } catch {
                    throw APIError.invalidResponse
                }
            }
            .observe(on: MainScheduler.instance)
    }
}

