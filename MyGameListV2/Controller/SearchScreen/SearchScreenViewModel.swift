//
//  SearchScreenViewModel.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 03/01/24.
//

import Foundation
import RxSwift

class SearchScreenViewModel {
    private let dataProvider: SearchScreenDataProvider
    private let disposeBag = DisposeBag()

    let searchResults: PublishSubject<Game> = PublishSubject()

    init(dataProvider: SearchScreenDataProvider) {
        self.dataProvider = dataProvider
    }

    func searchGames(withName name: String) {
        dataProvider.searchGames(withName: name)
            .subscribe(onNext: { [weak self] games in
                self?.searchResults.onNext(games)
            })
            .disposed(by: disposeBag)
    }
}
