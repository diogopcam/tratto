//
//  Primary.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI

struct ImageActionButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.white)
            }
            .frame(width: 100, height: 100)
            .background(Color.black)
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
