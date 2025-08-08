//
//  CollectionCard.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 06/08/25.
//


import SwiftUI

struct CollectionCard: View {
    
    var collection: Collection
    var isEditing: Bool = false
    var isSelected: Bool = false
    var action: (() -> Void)? = nil
    
    
    var title: String
    var images: [Image]
    var itemCount: Int
    
    let cardWidth: CGFloat = 164
    let cardHeight: CGFloat = 154

    init(collection: Collection, isEditing: Bool = false, isSelected: Bool = false, action: (() -> Void)? = nil) {
        self.collection = collection
        self.isEditing = isEditing
        self.isSelected = isSelected
        self.action = action
        self.title = collection.title
        self.itemCount = collection.references.count
        self.images = collection.references.compactMap { reference in
            if let uiImage = reference.image {
                return Image(uiImage: uiImage)
            }
            return nil
        }
    }

    var body: some View {
        Button(action: { action?() }) {
            VStack(alignment: .leading, spacing: 8) {
                // Container principal das imagens
                GeometryReader { geometry in
                    let containerWidth = geometry.size.width
                    let containerHeight = geometry.size.height
                    
                    // Lógica para layout dinâmico
                    if images.count == 1 {
                        images[0]
                            .resizable()
                            .scaledToFill()
                            .frame(width: containerWidth, height: containerHeight)
                            .clipped()
                    } else if images.count == 2 {
                        HStack(spacing: 0) {
                            ForEach(0..<2, id: \.self) { index in
                                images[index]
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: containerWidth/2, height: containerHeight)
                                    .clipped()
                            }
                        }
                    } else if images.count == 3 {
                        VStack(spacing: 0) {
                            images[0]
                                .resizable()
                                .scaledToFill()
                                .frame(width: containerWidth, height: containerHeight/2)
                                .clipped()
                            HStack(spacing: 0) {
                                images[1]
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: containerWidth/2, height: containerHeight/2)
                                    .clipped()
                                images[2]
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: containerWidth/2, height: containerHeight/2)
                                    .clipped()
                            }
                        }
                    } else {
                        // 4 ou mais imagens (grid 2x2)
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 0),
                                         GridItem(.flexible(), spacing: 0)], spacing: 0) {
                            ForEach(0..<min(4, images.count), id: \.self) { index in
                                images[index]
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: containerWidth/2, height: containerHeight/2)
                                    .clipped()
                            }
                        }
                    }
                }
                .frame(width: cardWidth, height: cardHeight)
                .background(Color(.systemGray5))
                .cornerRadius(24)
                
                // Título e quantidade (mantido igual)
                Text(title)
                    .font(.custom("HelveticaNeue-Bold", size: 17))
                    .lineLimit(1)
                
                Text("\(itemCount) item\(itemCount == 1 ? "" : "s")")
                    .font(.custom("HelveticaNeue-Thin", size: 12))
                    .foregroundColor(.gray)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    TabBar()
}
