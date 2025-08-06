//
//  Primary.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import PhotosUI

struct ImageActionButton: View {
    @Binding var selectedItem: PhotosPickerItem?  // binding para receber a seleção do pai

    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            VStack {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .foregroundStyle(.white)
                    .font(.system(size: 44, weight: .light))
            }
            .frame(width: 100, height: 100)
            .background(Color.black)
            .cornerRadius(22)
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(.gray, lineWidth: 0.7)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
