//
//  RecipeDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/2/23.
//

import Foundation

struct RapidRecipes: Codable{
    let results: [RapidRecipe]?
}

struct RapidRecipe: Codable{
    let id: Int?
    let title: String?
    let image: String?
}
