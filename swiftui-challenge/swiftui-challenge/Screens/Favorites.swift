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
            .navigationTitle("Coleções")
            .background(.backgroundPrimary)

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addRefs = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundStyle(.pink)
                    }
                }
            }
            .sheet(isPresented: $addRefs) {
                AddRefs()
            }
    }
}

#Preview {
    TabBar()
}
