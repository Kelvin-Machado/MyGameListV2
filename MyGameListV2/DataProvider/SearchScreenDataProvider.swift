//
//  SearchScreenDataProvider.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/01/24.
//

import Foundation
import RxSwift

protocol SearchScreenDataProviderProtocol {
    func searchGames(withName name: String) -> Observable<Game>
}

class SearchScreenDataProvider:  SearchScreenDataProviderProtocol {
    func searchGames(withName name: String) -> Observable<Game> {
        let request = APIRequest<Game>(path: "games/\(name)")
        return APIClient.shared.send(request)
    }
}
