//
//  CoinDetialsView.swift
//  Coins-iOS
//
//  Created by Aya Mahmoud on 22/09/2024.
//

import SwiftUI

struct CoinDetialsView: View {
    let coin: Coin
    @ObservedObject var viewModel: DetailsViewModel
    
    init(coin: Coin, service: NetworkManager) {
        self.coin = coin
        self.viewModel = DetailsViewModel(coinId: coin.id, service: service)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if let details = viewModel.coinDetails {
                Text(details.name.capitalized)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                
                Text(details.symbol.uppercased())
                    .font(.footnote)
                
                Text(details.description.text)
                    .font(.footnote)
                    .padding(.vertical)
            }
        }
        .task { await viewModel.fetchCoinDetails() }
        .padding()
    }
}

//#Preview {
//    CoinDetialsView()
//}
