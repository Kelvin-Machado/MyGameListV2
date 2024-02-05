//
//  AddSearchScreenDataProvider.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 04/02/24.
//

import Foundation
import RxSwift

protocol AddSearchScreenDataProviderProtocol {
    func searchGames(withName name: String) -> Observable<Result<Game, Error>>
   }

class AddSearchScreenDataProvider: AddSearchScreenDataProviderProtocol {
    func searchGames(withName name: String) -> Observable<Result<Game, Error>> {
        let request = APIRequest<Game>(path: "games/\(name)")
        return APIClient.shared.send(request)
            .map { Result.success($0) }
            .catch { error in
                Observable.just(Result.failure(error))
            }
    }
}


