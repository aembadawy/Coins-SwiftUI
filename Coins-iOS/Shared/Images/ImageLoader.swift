//
//  ImageLoader.swift
//  Coins-iOS
//
//  Created by Aya on 04/11/2024.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var imgae: Image?
    
    private var urlString: String
    
    init(url: String) {
        self.urlString = url
        Task { await loadImage()  }
    }
    
    @MainActor
    func loadImage() async {
        if let cached = ImageCache.shared.get(forKey: urlString) {
            self.imgae = Image(uiImage: cached)
            return
        }
        guard let url = URL(string: urlString) else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: data) else { return }
            ImageCache.shared.set(uiImage, forKey: urlString)
            self.imgae = Image(uiImage: uiImage)
        } catch {
            print("DEBUG: failed to fetch image")
        }
    }
}
