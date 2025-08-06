//
//  AddCollection.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//
import SwiftUI
import PhotosUI

struct AddCollection: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var collectionName: String = ""
    @State private var selectedImageData: Data?
    @State private var selectedItem: PhotosPickerItem? = nil
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24){
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Insira o nome da sua pasta")
                        .font(.custom("HelveticaNeue-Bold", size: 16))
                    
                    // TextField para o nome da pasta
                    TextField(" ", text: $collectionName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .tint(.pink)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Selecionar fotos da galeria")
                        .font(.custom("HelveticaNeue-Bold", size: 16))
                    
                    ImageActionButton(selectedItem: $selectedItem)
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    // trate a imagem aqui
                                    print("Imagem selecionada!")
                                }
                            }
                        }
                    
                    Spacer()
                }
            }
            .padding()
            .padding(.top, 38)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundSecondary)
            .navigationTitle("Criar nova pasta")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Botão de fechar no canto ESQUERDO
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44) // tamanho personalizado
                            .foregroundStyle(.gray)
                    }
                    .buttonStyle(PlainButtonStyle()) // evita botão inflado do sistema
                }
                
                // Botão de confirmar no canto DIREITO
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        print("Coleção salva!")
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundStyle(.pink)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

#Preview {
    AddCollection()
}
