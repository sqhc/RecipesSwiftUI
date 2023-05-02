//
//  QueryRecipesViewModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/2/23.
//

import Foundation
import Combine
import UIKit

class QueryRecipesViewModel: ObservableObject{
    var query: String
    
    var queryRecipesSearchString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?query="
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    @Published var recipes: RapidRecipes?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(query: String){
        self.query = query
    }
    
    func fetchRecipes(){
        queryRecipesSearchString += query
        
        guard let url = URL(string: queryRecipesSearchString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> RapidRecipes in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let recipes = try? decoder.decode(RapidRecipes.self, from: result.data) else{
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
                    self?.error = LoadError.custom(error: error)
                }
            } receiveValue: { [weak self] recipes in
                self?.recipes = recipes
            }
            .store(in: &bag)
    }
}

extension QueryRecipesViewModel{
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
