//
//  CoinDetails.swift
//  Coins-iOS
//
//  Created by Aya Mahmoud on 22/09/2024.
//

import Foundation

struct CoinDetails: Codable {
    let id, symbol, name: String
    let description: Description
}

struct Description: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
