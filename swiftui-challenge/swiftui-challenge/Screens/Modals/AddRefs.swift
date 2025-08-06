//
//  AddRefs.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import PhotosUI

struct AddRefs: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var collectionName: String = ""
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    func delete(at index: Int) {
        selectedImageData = nil
    }
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 24){
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Insira uma anotação sobre a referência")
                        .font(.custom("HelveticaNeue-Bold", size: 16))
                    
                    TextEditor(text: $collectionName)
                        .frame(height: 202) // altura fixa
                        .padding(8) // para não colar nas bordas
                        .background(Color(.black))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .tint(.pink)
                        .multilineTextAlignment(.leading) // alinhamento horizontal
                        .onAppear {
                            UITextView.appearance().backgroundColor = .clear // para garantir fundo transparente e não sobrepor cor
                        }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Selecionar uma foto da sua galeria")
                            .font(.custom("HelveticaNeue-Bold", size: 16))
                        
                        if let data = selectedImageData {
                            // Se já tem imagem, mostra o ImageDisplayRef
                            ImageDisplayRef(imageData: Binding(
                                get: { data },
                                set: { newValue in
                                    selectedImageData = newValue
                                }
                            )) {
                                // ação de deletar a imagem
                                selectedImageData = nil
                                selectedItem = nil
                            }
                            .frame(width: .infinity, height: 254) // Define tamanho fixo para o componente
                            
                            
                            
                        } else {
                            // Senão mostra o botão para escolher imagem
                            ImagePickerButton(selectedItem: $selectedItem)
                                .onChange(of: selectedItem) {
                                    Task {
                                        selectedImageData = nil
                                        if let item = selectedItem {
                                            if let data = try? await item.loadTransferable(type: Data.self) {
                                                selectedImageData = data
                                            }
                                        }
                                    }
                                }
                                .frame(width: .infinity, height: 254) // Define tamanho fixo para o componente
                        }
                        
                        Spacer()
                    }
                    
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(.gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Criar nova referência")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.top, 38)
                .padding(.horizontal, 16)
                .background(Color.backgroundSecondary)
            }
        }
    }
}
    
#Preview {
    AddRefs()
}
