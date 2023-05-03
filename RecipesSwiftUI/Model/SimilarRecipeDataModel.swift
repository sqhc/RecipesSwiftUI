//
//  SimilarRecipeDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/3/23.
//

import Foundation

struct SimilarRecipe: Codable{
    let id: Int?
    let title: String?
    let readyInMinutes: Int?
    let servings: Int?
}
