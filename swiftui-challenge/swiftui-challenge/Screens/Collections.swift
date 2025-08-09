//
//  Collections.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//
import SwiftUI
import SwiftData

struct Collections: View {
    @State var addCollection: Bool = false
    @Query var collections: [Collection]
    @Environment(\.modelContext) var context
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            contentView
                .navigationTitle("Coleções")
                .background(.backgroundPrimary)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addCollection = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .foregroundStyle(.pink)
                        }
                    }
                }
                .sheet(isPresented: $addCollection) {
                    AddCollection()
                }
                .navigationDestination(for: Collection.self) { collection in
                    CollectionDetail(collection: collection)
                }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if collections.isEmpty {
            CollectionsEmptyState(addCollection: $addCollection)
                .padding()
        } else {
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ],
                    spacing: 16
                ) {
                    ForEach(collections) { collection in
                        CollectionCard(collection: collection) {
                            navigationPath.append(collection)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    TabBar()
}
