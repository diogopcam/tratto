//
//  Primary.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import PhotosUI

struct ImageActionButton: View {
//    
    @Binding var selectedItems: [PhotosPickerItem]

    var body: some View {
        PhotosPicker(
            selection: $selectedItems,
            maxSelectionCount: 10,
            matching: .images,
            photoLibrary: .shared()
        ) {
            VStack {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .foregroundStyle(.white)
                    .font(.system(size: 44, weight: .light))
            }
            .frame(width: 113, height: 109)
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


