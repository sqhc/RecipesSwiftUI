//
//  MenuItemsDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import Foundation

struct RapidMenuItems: Codable{
    let menuItems: [RapidMenuItem]?
}

struct RapidMenuItem: Codable{
    let id: Int?
    let title: String?
    let image: String?
    let restaurantChain: String?
}
