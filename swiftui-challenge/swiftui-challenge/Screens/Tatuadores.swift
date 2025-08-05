//
//  ContentView.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI

// Protocolo, não classe
struct Tatuadores: View {
    
    // Variável computada que deve retornar uma view
    var body: some View {
//            ZStack {
//                Color.black.ignoresSafeArea()
            VStack() {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.pink)
                Text("Tela de tatuadores!").foregroundColor(.white)
            }
            .padding()
            .navigationTitle("Tatuadores")
            .background(.backgroundSecondary)
        }

//    }
}


#Preview {
    TabBar()
}
