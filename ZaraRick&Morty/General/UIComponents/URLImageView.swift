//
//  URLImageView.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 19/10/24.
//

import SwiftUI

struct URLImageView: View {
    @StateObject private var loader = ImageLoader()
    let url: String
    let placeholder: Image

    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            placeholder
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onAppear {
                    loader.load(from: url)
                }
        }
    }
}
