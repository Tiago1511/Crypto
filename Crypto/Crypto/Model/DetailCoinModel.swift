//
//  DetailCoinModel.swift
//  Crypto
//
//  Created by tiago on 16/02/2026.
//

import Foundation

struct DetailCoinModel: Hashable, Codable {
    let title: String?
    let data: [DetailCoin]
}

struct DetailCoin: Hashable, Codable {
    let title: String
    let value: String
}
