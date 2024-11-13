//
//  Recipes.swift
//  FetchRecipes
//
//  Created by Ahmed Irtija on 11/13/24.
//

import Foundation
import Combine

// ObservableObject class to handle data fetching and storage
class Recipes: ObservableObject {
    @Published var recipeList: [Recipe] = []
    @Published var errorMessage: String?

    struct RecipeResponse: Codable {
        let recipes: [Recipe]
    }

    struct Recipe: Codable, Identifiable {
        let id = UUID() // For SwiftUI List rendering
        let cuisine: String
        let name: String
        let photoURLLarge: String?
        let photoURLSmall: String?
        let uuid: String
        let sourceURL: String?
        let youtubeURL: String?
        
        enum CodingKeys: String, CodingKey {
            case cuisine, name
            case photoURLLarge = "photo_url_large"
            case photoURLSmall = "photo_url_small"
            case uuid
            case sourceURL = "source_url"
            case youtubeURL = "youtube_url"
        }
    }

    func fetchRecipes() {
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL.")
            self.errorMessage = "Invalid URL."
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: Failed to fetch data - \(error.localizedDescription)")
                    self?.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                    return
                }

                guard let data = data, !data.isEmpty else {
                    print("Error: No data received or data is empty.")
                    self?.errorMessage = "No data received."
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(RecipeResponse.self, from: data)
                    self?.recipeList = decodedData.recipes
                    if decodedData.recipes.isEmpty {
                        self?.errorMessage = "No recipes found."
                    }
                } catch {
                    print("Error: Failed to decode JSON - \(error.localizedDescription)")
                    self?.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
