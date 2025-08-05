//
//  AddRefs.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//


import SwiftUI

struct AddRefs: View {
    
    @Environment(\.dismiss) var dismiss // Para fechar o modal
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Conteúdo do modal aqui")
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundSecondary) // Cor de fundo
            .navigationTitle("Criar nova pasta") // Título no topo
            .navigationBarTitleDisplayMode(.inline) // Título centralizado
            .toolbar {
                // Botão de fechar no canto ESQUERDO
                               ToolbarItem(placement: .cancellationAction) {
                                   Button {
                                       dismiss() // fecha o modal
                                   } label: {
                                       Image(systemName: "xmark.circle.fill")
                                           .foregroundColor(.gray)
                                   }
                               }

                               // Botão de confirmar no canto DIREITO
                               ToolbarItem(placement: .confirmationAction) {
                                   Button {
                                       print("Coleção salva!")
                                       dismiss()
                                   } label: {
                                       Image(systemName: "arrow.up.circle.fill")
                                           .foregroundColor(.pink)
                                   }
                               }
            }
        }
    }
}

#Preview {
    AddRefs()
}
