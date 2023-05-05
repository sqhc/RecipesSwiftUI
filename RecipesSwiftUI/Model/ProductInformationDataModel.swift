//
//  ProductInformationDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import Foundation

struct ProductInformation: Codable{
    let title: String?
    let price: Double?
    let likes: Int?
    let nutrition: ProductNutrientions?
    let servings: ProductServings?
    let image: String?
    let upc: String?
    let ingredientList: String?
}

struct ProductNutrientions: Codable{
    let nutrients: [ProductNutriention]?
}

struct ProductNutriention: Codable{
    let name: String?
    let amount: Double?
    let unit: String?
}

struct ProductServings: Codable{
    let number: Double?
    let size: Double?
    let unit: String?
}
