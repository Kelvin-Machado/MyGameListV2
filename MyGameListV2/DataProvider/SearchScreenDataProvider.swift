//
//  SearchScreenDataProvider.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/01/24.
//

import Foundation
import RxSwift

protocol SearchScreenDataProviderProtocol {
    func searchGames(withName name: String) -> Observable<Result<Game, Error>>
   }

class SearchScreenDataProvider: SearchScreenDataProviderProtocol {
    func searchGames(withName name: String) -> Observable<Result<Game, Error>> {
        let request = APIRequest<Game>(path: "games/\(name)")
        return APIClient.shared.send(request)
            .map { Result.success($0) }
            .catch { error in
                Observable.just(Result.failure(error))
            }
    }
}

