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
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImageDatas: [Data] = []
    
    func delete(at index: Int) {
        selectedImageDatas.remove(at: index)
    }
    

    @Environment(\.modelContext) var context
//       let viewModel = ColecaoViewModel()
       @State private var nome = ""
    
    
    
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 24){
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Insira o nome da sua pasta")
                        .font(.custom("HelveticaNeue-Bold", size: 16))
                    
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
                    
                    // Primeira "linha customizada" com o botão + duas primeiras imagens
                    HStack(alignment: .center, spacing: 12) {
                        ImageActionButton(selectedItems: $selectedItems)
                            .onChange(of: selectedItems) {
                                Task {
                                    selectedImageDatas = []
                                    for item in selectedItems {
                                        if let data = try? await item.loadTransferable(type: Data.self) {
                                            selectedImageDatas.append(data)
                                        }
                                    }
                                }
                            }

                        if selectedImageDatas.indices.contains(0) {
                            ImageDisplay(imageData: $selectedImageDatas[0], onDelete: { delete(at: 0) })
                        }

                        if selectedImageDatas.indices.contains(1) {
                            ImageDisplay(imageData: $selectedImageDatas[1], onDelete: { delete(at: 1)})
                        }
                    }
                    
                      LazyVGrid(
                        columns: columns,
                        alignment: .leading,
                        spacing: 12
                      
                      ) {
                          ForEach(selectedImageDatas.indices.dropFirst(2), id: \.self) { index in
                              ImageDisplay(imageData: $selectedImageDatas[index], onDelete: { delete(at: index) })
                          }
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
                            let newCollection = Collection(title: collectionName)
                            
                            for data in selectedImageDatas {
                                if let uiImage = UIImage(data: data) {
                                    let reference = Reference(text: nil, image: uiImage, collection: newCollection)
                                    newCollection.references.append(reference)
                                }
                            }
                            
            
                            context.insert(newCollection)
                            
                            do {
                                try context.save()
                                print("Coleção salva com sucesso!")
                            } catch {
                                print("Erro ao salvar coleção:", error)
                            }
                                
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
            .navigationTitle("Criar nova pasta")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 38)
            .padding(.horizontal, 16)
            .background(Color.backgroundSecondary)
        }
    }
}

#Preview {
    AddCollection()
}
