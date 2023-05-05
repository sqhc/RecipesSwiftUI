//
//  ProudctsDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import Foundation

struct RapidProducts: Codable{
    let products: [RapidProduct]?
}

struct RapidProduct: Codable{
    let image: String?
    let id: Int?
    let title: String?
}

struct AutoCompleteProducts: Codable{
    let results: [RapidProduct]?
}
