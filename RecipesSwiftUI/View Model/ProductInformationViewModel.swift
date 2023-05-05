//
//  ProductInformationViewModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import Foundation
import Combine

class ProductInformationViewModel: ObservableObject{
    let id: Int
    
    var searchProductInformationString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/products/"
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    @Published var information: ProductInformation?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(id: Int){
        self.id = id
    }
    
    func fetchInformation(){
        searchProductInformationString += "\(id)"
        
        guard let url = URL(string: searchProductInformationString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> ProductInformation in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let information = try? decoder.decode(ProductInformation.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return information
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] info in
                self?.information = info
            }
            .store(in: &bag)
    }
}

extension ProductInformationViewModel{
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
