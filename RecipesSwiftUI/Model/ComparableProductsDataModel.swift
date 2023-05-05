//
//  ComparableProductsDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import Foundation

struct ComparableProducts: Codable{
    let comparableProducts: ComparableProduct?
}

struct ComparableProduct: Codable{
    let price: [ComparedInfo]?
    let spoonacular_score: [ComparedInfo]?
    let likes: [ComparedInfo]?
    let sugar: [ComparedInfo]?
    let protein: [ComparedInfo]?
    let calories: [ComparedInfo]?
}

struct ComparedInfo: Codable{
    let image: String?
    let difference: Int?
    let id: Int?
    let title: String?
}
