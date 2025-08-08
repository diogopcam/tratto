//
//  ContentView.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import SwiftData  // importante para usar ModelContext

struct Tatuadores: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            Button("Criar coleção teste") {
                let nova = Collection(title: "Coleção de teste \(Date())")
                context.insert(nova)
                do {
                    try context.save()
                    print("Coleção salva com sucesso!")
                } catch {
                    print("Erro ao salvar coleção:", error)
                }
            }
            .padding()
            
            // Aqui você pode adicionar outras views da tela de tatuadores
            Text("Tela Tatuadores")
        }
        .padding()
    }
}

#Preview {
    TabBar()
}

