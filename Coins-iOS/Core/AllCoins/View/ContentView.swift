//
//  ContentView.swift
//  Coins-iOS
//
//  Created by Aya Mahmoud on 06/09/2024.
//

import SwiftUI

struct ContentView: View {
    private var service: NetworkManager
    
    @StateObject var viewModel: CoinsViewModel
    
    init(service: NetworkManager) {
        self.service = service
        self._viewModel = StateObject(wrappedValue: CoinsViewModel(service: service))
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.coins) { coin in
                    NavigationLink(value: coin){
                        HStack {
                            Text("\(coin.marketCapRank)")
                                .foregroundStyle(.gray)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(coin.name.capitalized)").fontWeight(.semibold)
                                
                                Text("\(coin.symbol.uppercased())")
                                    
                            }
                        }.font(.footnote)
                    }
                }
            }.navigationDestination(for: Coin.self, destination: { coin in
                CoinDetialsView(coin: coin, service: service)
            })
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
}

#Preview {
    ContentView(service: NetworkManager())
}
