//
//  SearchProductsViewModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import Foundation

class SearchProductsViewModel: ObservableObject{
    @Published var query = ""
    @Published var number = 10
    @Published var autocomplete = ""
}
