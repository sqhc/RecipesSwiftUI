//
//  MenuItemAutoCompleteDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import Foundation

struct AutoCompleteMenuItems: Codable{
    let results: [AutoCompleteMenuItem]?
}

struct AutoCompleteMenuItem: Codable{
    let title: String?
    let id: Int?
}
