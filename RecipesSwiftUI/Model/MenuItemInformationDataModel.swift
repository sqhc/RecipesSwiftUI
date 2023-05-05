//
//  MenuItemInformationDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import Foundation

struct MenuItemInformation: Codable{
    let title: String?
    let nutrition: ProductNutrientions?
    let image: String?
    let restaurantChain: String?
}
