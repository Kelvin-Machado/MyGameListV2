//
//  SearchScreenDataProvider.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/01/24.
//

import Foundation
import RxSwift

protocol SearchScreenDataProviderProtocol {
    func searchGames(withName name: String) -> Observable<Result<Search, Error>>
   }

class SearchScreenDataProvider: SearchScreenDataProviderProtocol {
    func searchGames(withName name: String) -> Observable<Result<Search, Error>> {
        let request = APIRequest<Search>(path: "games", parameters: ["search": name])
        return APIClient.shared.send(request)
            .map { Result.success($0) }
            .catch { error in
                Observable.just(Result.failure(error))
            }
    }
}
