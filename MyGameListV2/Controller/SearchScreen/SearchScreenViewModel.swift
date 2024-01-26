//
//  SearchScreenViewModel.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 03/01/24.
//

import Foundation
import RxSwift

class SearchScreenViewModel {
    private let dataProvider: SearchScreenDataProviderProtocol
    private let disposeBag = DisposeBag()

    let searchResults: PublishSubject<Result<Game, Error>> = PublishSubject()

    init(dataProvider: SearchScreenDataProviderProtocol = SearchScreenDataProvider()) {
        self.dataProvider = dataProvider
    }

    func searchGames(withName name: String) {
        dataProvider.searchGames(withName: name)
            .subscribe(onNext: { [weak self] result in
                self?.searchResults.onNext(result)
            })
            .disposed(by: disposeBag)
    }
}
