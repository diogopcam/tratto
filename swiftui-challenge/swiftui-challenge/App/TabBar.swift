//
//  TabBar.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import SwiftData

struct TabBar: View {    
    var body: some View {
        
        TabView {
            // Tatuadores
//            Tab("Tatuadores", systemImage: "person.2.fill") {
//                
//                // Cada aba é reponsável por uma pilha de navegacao
//                NavigationStack {
//                    Tatuadores()
//                }
//            }
            
            // Tatuadores
            Tab("Coleções", systemImage: "photo.fill") {
                
                // Cada aba é reponsável por uma pilha de navegacao
                NavigationStack {
                    Collections()
                }
            }
            
//            Tab("Favoritos", systemImage: "heart.fill") {
//                
//                // Cada aba é reponsável por uma pilha de navegacao
//                NavigationStack {
//                    Favorites()
//                }
//            }
        }
        .tint(.pink)
    }
}

#Preview {
    TabBar()
}
