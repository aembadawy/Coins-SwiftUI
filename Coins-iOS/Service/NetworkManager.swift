//
//  NetworkManager.swift
//  Coins-iOS
//
//  Created by Aya Mahmoud on 07/09/2024.
//

import Foundation

protocol HTTPDataDownloader {
    func fetchData<T: Codable>(as type: T.Type, endpoint: String) async throws -> T
}

extension HTTPDataDownloader {
    
    func fetchData<T: Codable>(as type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw APError.requestFailed(description: "Invalid URL")
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APError.requestFailed(description: "Invalid Response")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APError.invalidStatusCode(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw APError.jsonParsingFailure
        }
    }
}

class NetworkManager: HTTPDataDownloader {
    
    init() {
        print("DEBUG: NW setup.")
    }
    
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false&price_change_percentage=24h&locale=en"
        
    func fetchCoins() async throws -> [Coin] {
        return try await fetchData(as: [Coin].self, endpoint: urlString)
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        if let cachedCoin = CoinDetailsCache.shared.get(forkey: id) {
            print("DEBUG: Using cached coin details for \(id).")
            return cachedCoin
        } else {
            let detailsUrlString = "https://api.coingecko.com/api/v3/coins/\(id)?localization=false"
            let data = try await fetchData(as: CoinDetails.self, endpoint: detailsUrlString)
            print("DEBUG: Fetched coin details for \(id).")
            CoinDetailsCache.shared.set(data, forkey: id)
            return data
        }
    }
}

extension NetworkManager {
    
    func fetchCoinsWithResult(completion: @escaping(Result<[Coin], APError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Debug: Error \(error.localizedDescription)")
                completion(.failure(.unknownError(description: error.localizedDescription)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request Failed")))
                return
            }

            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(response))
            } catch { //we get access to error inside the catch block by default
                print("Debug: Failed to decode object \(error)")
                completion(.failure(.jsonParsingFailure))
            }
        }.resume()
    }
}
