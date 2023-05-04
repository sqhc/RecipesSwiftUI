//
//  IngredientInfoDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import Foundation

struct IngredientInformation: Codable{
    let name: String?
    let possibleUnits: [String]?
    let consistency: String?
    let shoppingListUnits: [String]?
    let categoryPath: [String]?
}
