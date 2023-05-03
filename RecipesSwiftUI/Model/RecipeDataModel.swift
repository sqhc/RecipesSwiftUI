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

struct RecipeFromIngredient: Codable{
    let id: Int?
    let title: String?
    let image: String?
    let usedIngredients: [IngredientOfRecipe]?
    let likes: Int?
}

struct IngredientOfRecipe: Codable{
    let id: Int?
    let aisle: String?
    let original: String?
    let image: String?
}
