//
//  CoinsViewModel.swift
//  Coins-iOS
//
//  Created by Aya Mahmoud on 06/09/2024.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    @Published var errorMessage: String?
    
    private let networkManager = NetworkManager()
    
    init() {
        fetchCoins()
    }
    
    func fetchCoins() {
        networkManager.fetchCoinsWithResult { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self.coins = coins
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
