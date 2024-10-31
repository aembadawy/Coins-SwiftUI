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
    
    private let networkManager: NetworkManager
    
    init(service: NetworkManager) {
        self.networkManager = service
        Task { await fetchCoins() }
    }
    
    @MainActor
    func fetchCoins() async {
        do {
            self.coins = try await networkManager.fetchCoins()
        } catch {
            guard let error = error as? APError else {
                errorMessage = "Unknown Error Occured"
                return
            }
            errorMessage = error.localizedDescription
        }
    }
    func fetchCoinsWithResult() {
        networkManager.fetchCoinsWithResult { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
