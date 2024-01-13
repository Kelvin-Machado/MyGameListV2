//
//  SearchScreenDataProvider.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/01/24.
//

import Foundation
import RxSwift

class SearchScreenDataProvider {
    func searchGames(withName name: String) -> Observable<Game> {
        let request = APIRequest<Game>(path: "games/\(name)")
        return APIClient.shared.send(request)
    }
}
