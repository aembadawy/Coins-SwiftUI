//
//  DetailsViewModel.swift
//  Coins-iOS
//
//  Created by Aya Mahmoud on 22/09/2024.
//

import Foundation

class DetailsViewModel: ObservableObject {
    let coinId: String //Dependency injection -> This view model depends on a CoinId that must be injected on creation
    private let networkManager: NetworkManager

    @Published var coinDetails: CoinDetails?
    
    init (coinId: String, service: NetworkManager) {
        self.coinId = coinId
        self.networkManager = service
    }
    
    @MainActor
    func fetchCoinDetails() async {
//        try? await Task.sleep(nanoseconds: 2_000_000_000)
        do {
            let details = try await networkManager.fetchCoinDetails(id: coinId)
            self.coinDetails = details
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}
