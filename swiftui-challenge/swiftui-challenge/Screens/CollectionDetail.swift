//
//  CollectionDetail.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 08/08/25.
//

import SwiftUI
import SwiftData

struct CollectionDetail: View {
    let collection: Collection
    @State private var addRefs = false
    
    var body: some View {
            VStack {
                if collection.references.isEmpty {
                    Spacer() // Empurra o conteúdo para baixo
                    
                    RefsEmptyState(addRefs: $addRefs)
                    
                    Spacer() // Empurra o conteúdo para cima
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16) {
                            ForEach(collection.references) { reference in
                                ReferenceCard(reference: reference)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(collection.title)
            .background(.backgroundPrimary)
    }
}
