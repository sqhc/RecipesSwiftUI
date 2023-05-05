//
//  SearchMenuItemsViewModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import Foundation

class SearchMenuItemsViewModel: ObservableObject{
    @Published var query = ""
    @Published var number = 10
}
