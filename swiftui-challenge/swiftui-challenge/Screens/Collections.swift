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
    @Environment(\.modelContext) var modelContext
    @State private var navigationPath = NavigationPath()
    
    
    private var shouldHideTabBar: Bool {
        !selectedCollections.isEmpty || isEditing
    }
    
    @State private var isEditing = false
//    @State private var selectedCollections = Set<Collection>()
    @State private var selectedCollections = Set<Collection>()
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            contentView
                .navigationTitle("Coleções")
                .toolbar(shouldHideTabBar ? .hidden : .visible, for: .tabBar)
                .background(.backgroundPrimary)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        if selectedCollections.isEmpty {
                            Button {
                                addCollection = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(.pink)
                            }
                        } else {
                            Button {
                                showDeleteConfirmation = true
                            } label: {
                                Image(systemName: "trash.circle.fill")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .font(.system(size: 44, weight: .thin))
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.red, .black)
                                
                                    .shadow(color: Color.gray.opacity(0.6), radius: 8, x: 0, y: 4)
                                }
                            .alert("Tem certeza que deseja excluir estas coleções?", isPresented: $showDeleteConfirmation) {
                                Button("Cancelar", role: .cancel) { }
                                Button("Excluir", role: .destructive) {
                                    deleteSelectedCollections()
                                }
                            }
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
                        CollectionCard(
                            collection: collection,
                            isEditing: isEditing,
                            isSelected: selectedCollections.contains(collection),
                            onTap: {
                                print("Toque simples detected on collection: \(collection.title)")
                                if isEditing {
                                    if selectedCollections.contains(collection) {
                                        selectedCollections.remove(collection)
                                    } else {
                                        selectedCollections.insert(collection)
                                    }
                                } else {
                                    navigationPath.append(collection)
                                }
                            },
                            onLongPress: {
                                print("Long press detected on collection: \(collection.title)")
                                withAnimation {
                                    isEditing = true
                                }
                            }
                        )
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if isEditing {
                    withAnimation {
                        isEditing = false
                        selectedCollections.removeAll()
                    }
                }
            }
        }
    }
    
    func deleteSelectedCollections() {
        do {
            try modelContext.transaction {
                // Se você armazenar IDs, precisa buscar os objetos correspondentes antes de deletar
                for collection in collections where selectedCollections.contains(collection) {
                    modelContext.delete(collection)
                }
            }
            selectedCollections.removeAll()
        } catch {
            print("Erro ao excluir collections: \(error.localizedDescription)")
        }
    }
}

#Preview {
    TabBar()
}
