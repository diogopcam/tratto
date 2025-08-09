//
// Favoritos.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI

// Protocolo, não classe
struct Favorites: View {
    
    @State var addRefs: Bool = false
    
    // Variável computada que deve retornar uma view
    var body: some View {
        RefsEmptyState(addRefs: $addRefs)
            .padding()
            .navigationTitle("Favoritos")
            .background(.backgroundPrimary)

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addRefs = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundStyle(.pink)
                    }
                }
            }
    }
}

#Preview {
    TabBar()
}
