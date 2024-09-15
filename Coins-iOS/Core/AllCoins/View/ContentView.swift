//
//  ContentView.swift
//  Coins-iOS
//
//  Created by Aya Mahmoud on 06/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()
    var body: some View {
        List {
            ForEach(viewModel.coins) { coin in
                HStack {
                    Text("\(coin.marketCapRank)")
                        .foregroundStyle(.gray)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(coin.name.capitalized)").fontWeight(.semibold)
                        
                        Text("\(coin.symbol.uppercased())")
                            
                    }
                }.font(.footnote)
            }
        }.overlay {
            if let error = viewModel.errorMessage {
                Text(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
