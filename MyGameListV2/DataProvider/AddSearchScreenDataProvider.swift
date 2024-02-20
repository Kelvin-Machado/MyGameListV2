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
    func screenshots(withName name: String) -> Observable<Result<GameScreenshots, Error>>
   }

class AddSearchScreenDataProvider: AddSearchScreenDataProviderProtocol {
    func screenshots(withName name: String) -> RxSwift.Observable<Result<GameScreenshots, Error>> {
        let request = APIRequest<GameScreenshots>(path: "games/\(name)/screenshots")
        return APIClient.shared.send(request)
            .map { Result.success($0) }
            .catch { error in
                Observable.just(Result.failure(error))
            }
    }
    
    func searchGames(withName name: String) -> Observable<Result<Game, Error>> {
        let request = APIRequest<Game>(path: "games/\(name)")
        return APIClient.shared.send(request)
            .map { Result.success($0) }
            .catch { error in
                Observable.just(Result.failure(error))
            }
    }
}


