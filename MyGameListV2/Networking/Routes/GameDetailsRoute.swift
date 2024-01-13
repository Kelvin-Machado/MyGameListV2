//
//  GameDetailsRoute.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/01/24.
//

//import Foundation
//
//// Um exemplo de implementação de uma solicitação específica para obter a lista de jogos
//class GamesListRequest: APIRequest {
//    var method = RequestType.GET
//    var path = "games"
//    var parameters = [String: String]()
//}
//
//// Um exemplo de implementação de uma solicitação para obter informações sobre um jogo específico
//class GameDetailsRequest: APIRequest {
//    var method = RequestType.GET
//    var path: String
//    var parameters = [String: String]()
//
//    init(gameSlug: String) {
//        self.path = "games/\(gameSlug)"
//    }
//}
//
//// Um exemplo de implementação de uma solicitação para obter a lista de jogos ordenados por data de lançamento
//class GamesByReleaseDateRequest: APIRequest {
//    var method = RequestType.GET
//    var path = "games"
//    var parameters: [String: String]
//
//    init(ordering: String = "released") {
//        self.parameters = ["ordering": ordering]
//    }
//}
