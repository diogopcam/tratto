//
//  Collections.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI

// Protocolo, não classe
struct Collections: View {
    
    @State var addCollection: Bool = false
    
    // Variável computada que deve retornar uma view
    var body: some View {
        CollectionsEmptyState(addCollection: $addCollection)
            .padding()
            .navigationTitle("Coleções")
            .background(.backgroundPrimary)

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addCollection = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundStyle(.pink)
                    }
                }
            }
            .sheet(isPresented: $addCollection) {
                AddCollection()
            }
    }
}

#Preview {
    TabBar()
}
