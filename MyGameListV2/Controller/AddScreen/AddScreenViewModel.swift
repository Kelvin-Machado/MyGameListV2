//
//  AddScreenViewModel.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 04/02/24.
//

import Foundation
import RxSwift

class AddScreenViewModel {
    private let dataProvider: AddScreenDataProviderProtocol
    private let disposeBag = DisposeBag()

    let searchResults: PublishSubject<Result<Game, Error>> = PublishSubject()

    init(dataProvider: AddScreenDataProviderProtocol = AddScreenDataProvider()) {
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
