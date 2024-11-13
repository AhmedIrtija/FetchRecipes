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
            VStack {
                if let errorMessage = recipes.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }

                List(recipes.recipeList) { recipe in
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.headline)
                        Text("Cuisine: \(recipe.cuisine)")
                            .font(.subheadline)
                    }
                }

                Button("Fetch Recipes") {
                    Task {
                        await recipes.fetchRecipes()
                    }
                }
                .padding()
            }
        }
    }

#Preview {
    RecipeView()
}
