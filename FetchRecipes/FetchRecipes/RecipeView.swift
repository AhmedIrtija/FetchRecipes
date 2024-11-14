//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Ahmed Irtija on 11/13/24.
//

import SwiftUI
import Kingfisher

struct RecipeView: View {
    @StateObject private var recipes = Recipes()
    @State private var selectedSortOption: SortOption = .none
    
    enum SortOption: String, CaseIterable, Identifiable {
        case none = "None"
        case nameAZ = "Name A-Z"
        case nameZA = "Name Z-A"
        case cuisine = "Cuisine"
        
        var id: String { self.rawValue }
    }
    
    var sortedRecipes: [Recipes.Recipe] {
        switch selectedSortOption {
        case .none:
            return recipes.recipeList
        case .nameAZ:
            return recipes.recipeList.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .nameZA:
            return recipes.recipeList.sorted { $0.name.lowercased() > $1.name.lowercased() }
        case .cuisine:
            return recipes.recipeList.sorted { $0.cuisine.lowercased() < $1.cuisine.lowercased() }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                
                // Sort picker
                HStack {
                    Text("Recipes")
                        .foregroundColor(.orange)
                        .frame(alignment: .center)
                        .padding()
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    Menu {
                        Picker("Sort By", selection: $selectedSortOption) {
                            ForEach(SortOption.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down.circle")
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundColor(.orange)
                    }
                    .padding()
                }
                
                if let errorMessage = recipes.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .frame(alignment: .center)
                        .padding()
                }
                List(sortedRecipes) { recipe in
                    HStack {
                        if let photoURLSmall = recipe.photoURLSmall, let url = URL(string: photoURLSmall) {
                            KFImage(url)
                                .placeholder {
                                    ProgressView() // Loading spinner while image loads
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                        }
                        // Name and Cuisine
                        VStack(alignment: .leading) {
                            if let sourceURL = recipe.sourceURL, let url = URL(string: sourceURL) {
                                Link(destination: url) {
                                    Text(recipe.name)
                                        .font(.headline)
                                    
                                }
                            } else {
                                Text(recipe.name)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                            }
                            
                            Text("Cuisine: \(recipe.cuisine)")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        // YouTube play button on the right side
                        if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                            Link(destination: url) {
                                Image(systemName: "play.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.orange)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical, 5)
                    .listRowBackground(Color.white)
                }
                .refreshable {
                    // Fetch recipes when user pulls to refresh
                    await recipes.fetchRecipes()
                }
            }
            .task {
                // Initial loading data when it appears
                await recipes.fetchRecipes()
            }
            .background(Color.white)
        }
    }
}


