//
//  AddSearchScreenViewModel.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 04/02/24.
//

import Foundation
import RxSwift

class AddSearchScreenViewModel {
    private let dataProvider: AddSearchScreenDataProviderProtocol
    private let disposeBag = DisposeBag()

    let searchResults: PublishSubject<Result<Game, Error>> = PublishSubject()

    init(dataProvider: AddSearchScreenDataProviderProtocol = AddSearchScreenDataProvider()) {
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
