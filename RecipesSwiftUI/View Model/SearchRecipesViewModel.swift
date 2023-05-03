//
//  SearchRecipesViewModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/2/23.
//

import Foundation

class SearchRecipesViewModel: ObservableObject{
    @Published var query = ""
    @Published var ingredients = ""
    @Published var number = 5
}
