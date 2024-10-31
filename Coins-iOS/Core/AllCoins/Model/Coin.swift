//
//  Coin.swift
//  Coins-iOS
//
//  Created by Aya Mahmoud on 07/09/2024.
//

import Foundation

struct Coin: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let currentPrice: Double
    let marketCapRank: Int
    
    //To specify the exact spelling of coding keys.
    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
    }
}
