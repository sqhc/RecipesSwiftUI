//
//  SearchIngredientsViewModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/3/23.
//

import Foundation

class SearchIngredientsViewModel: ObservableObject{
    @Published var query = ""
    @Published var number = 10
    @Published var autoComplete = ""
}
