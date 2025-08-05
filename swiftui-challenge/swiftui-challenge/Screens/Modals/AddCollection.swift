//
//  AddCollection.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//
import SwiftUI

struct AddCollection: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var collectionName: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Nome da pasta")
                        .font(.caption)
                        .foregroundColor(.secondary)
                
                // TextField para o nome da pasta
                    TextField("Insira o nome da sua pasta", text: $collectionName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                
                ImageActionButton {
                    print("Ação: upload de imagem")
                    // aqui pode abrir um picker futuramente
                }
                
                // Botão reutilizável
                
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundSecondary)
            .navigationTitle("Criar nova pasta")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }

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
