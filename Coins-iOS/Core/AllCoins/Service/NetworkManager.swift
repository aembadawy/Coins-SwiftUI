//
//  NetworkManager.swift
//  Coins-iOS
//
//  Created by Aya Mahmoud on 07/09/2024.
//

import Foundation

class NetworkManager {
    
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false&price_change_percentage=24h&locale=en"
    
    func fetchCoinsWithResult(completion: @escaping(Result<[Coin], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Debug: Error \(error.localizedDescription)")
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(response))
            } catch {
                print("Debug: Failed to decode object")
            }
        }.resume()
    }
    
    func fetchCoins(completion: @escaping([Coin]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Debug: Error \(error.localizedDescription)")
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode([Coin].self, from: data)
                completion(response)
            }catch {
                print("Debug: Failed to decode object")
            }
        }.resume()
    }
}

