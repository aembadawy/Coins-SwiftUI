//
//  ImageView.swift
//  Coins-iOS
//
//  Created by Aya on 04/11/2024.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        self.imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        if let image = imageLoader.imgae {
            image
                .resizable()
        }
    }
}

#Preview {
    ImageView(
        url: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579"
    )
}
