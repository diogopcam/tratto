//
//  ReferenceDetail.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 09/08/25.
//

import SwiftUI

struct ReferenceDetail: View {
    let reference: Reference
    @Environment(\.dismiss) private var dismiss


    var creationDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: reference.creationDate)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let uiImage = reference.image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill() // Preenche todo o espaço disponível
                        .frame(width: UIScreen.main.bounds.width) // Largura total da tela
                        .clipped() // Corta o excesso se a imagem for maior que a tela
                        .cornerRadius(0) // Remove bordas arredondadas para ocupar toda a largura
                        .shadow(radius: 4)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                        .cornerRadius(16)
                }

                if let text = reference.text, !text.isEmpty {
                    Text(text)
                        .font(.custom("HelveticaNeue-Regular", size: 16))
                        .foregroundColor(.primary)
                        .padding(.vertical, 4)
                        .padding(.horizontal) // Adiciona padding horizontal para o texto
                }

                Text("Criada em \(creationDateFormatted)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.horizontal) // Adiciona padding horizontal para a data

                Spacer()
            }
            .frame(maxWidth: .infinity) // Garante que o VStack ocupe toda a largura
        }
        .edgesIgnoringSafeArea(.all) // Opcional: se quiser que a imagem vá até as bordas
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) { // Chama dismiss() para voltar
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.pink)
                                }
            }
        }
    }
}
