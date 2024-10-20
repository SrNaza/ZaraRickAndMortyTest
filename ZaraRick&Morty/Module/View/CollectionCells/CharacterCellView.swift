//
//  CharacterCellView.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 19/10/24.
//

import SwiftUI

struct CharacterCellView: View {
    let character: Character
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Imagen del personaje
            URLImageView(url: character.image, placeholder: Image(systemName: "photo"))
                .frame(width: 172, height: 200)
                .cornerRadius(20)
                .clipped()
            
            // Nombre del personaje
            Text(character.name)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.black)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            // Especie del personaje
            Text("Species: \(character.species)")
                .font(.system(size: 15))
                .foregroundColor(.black)
                .lineLimit(2)
        }
        .padding()
        .background(Color(red: 0.5098, green: 0.7843, blue: 0.2706))
        .cornerRadius(20)
    }
}

struct CharacterCellView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCellView(character: Character.mock)
            .previewLayout(.sizeThatFits)
    }
}
