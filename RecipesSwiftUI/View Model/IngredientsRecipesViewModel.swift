//
//  IngredientsRecipesViewModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/3/23.
//

import Foundation
import Combine

class IngredientsRecipesViewModel: ObservableObject{
    let ingredients: String
    let number: Int
    
    var ingredientsRecipesSearchString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?ingredients="
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    @Published var recipes: [RecipeFromIngredient]?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(ingredients: String, number: Int){
        self.ingredients = ingredients
        self.number = number
    }
    
    func fetchRecipes(){
        ingredientsRecipesSearchString += "\(ingredients)&number=\(number)"
        
        guard let url = URL(string: ingredientsRecipesSearchString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> [RecipeFromIngredient] in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                
                let decoder = JSONDecoder()
                guard let recipes = try? decoder.decode([RecipeFromIngredient].self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return recipes
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] recipes in
                self?.recipes = recipes
            }
            .store(in: &bag)
    }
}

extension IngredientsRecipesViewModel{
    enum LoadError: LocalizedError{
        case custom(error: Error)
        case failedToDecode
        case invalidStatusCode
        case failedToUnwrapOptional
        
        var errorDescription: String?{
            switch self {
            case .custom(let error):
                return error.localizedDescription
            case .failedToDecode:
                return "Failed to decode the data."
            case .invalidStatusCode:
                return "Get Request failed due to invalid status code."
            case .failedToUnwrapOptional:
                return "Unable to unwrap the optional value."
            }
        }
    }
}
