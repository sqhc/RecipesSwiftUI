//
//  IngredientsDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import Foundation

struct RapidIngredients: Codable{
    let results: [RapidIngredient]?
}

struct RapidIngredient: Codable{
    let id: Int?
    let name: String?
}
