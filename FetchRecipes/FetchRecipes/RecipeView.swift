//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Ahmed Irtija on 11/13/24.
//

import SwiftUI

struct RecipeView: View {
    @StateObject private var recipes = Recipes()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let errorMessage = recipes.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
                
                List(recipes.recipeList) { recipe in
                    HStack {
                        if let photoURLSmall = recipe.photoURLSmall, let url = URL(string: photoURLSmall) {
                            AsyncImage(url: url) { phase in
                                // Switch case for making sure image appears or has a default
                                switch phase {
                                case .empty:
                                    ProgressView() // Loading spinner while image loads to make it look nice
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50) // Adjust size as needed
                                        .cornerRadius(8)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .id(recipe.uuid)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                        }
                        // Name and Cuisine
                        VStack(alignment: .leading) {
                            Text(recipe.name)
                                .font(.headline)
                            Text("Cuisine: \(recipe.cuisine)")
                                .font(.subheadline)
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
                        }
                        
                    }
                    .padding(.vertical, 5)
                }
                
            }
            .task {
                // Initial loading data when it appears
                await recipes.fetchRecipes()
            }
        }
        
    }
}


#Preview {
    RecipeView()
}
