//
//  ComparableProductsView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import SwiftUI

struct ComparableProductsView: View {
    @StateObject var vm: ComparableProductsViewModel
    
    var body: some View {
        ZStack{
            if let products = vm.products?.comparableProducts{
                VStack{
                    if let prices = products.price{
                        CompareProductsItem(title: "Prices", products: prices)
                    }
                    if let scores = products.spoonacular_score{
                        CompareProductsItem(title: "Scroes", products: scores)
                    }
                    if let likes = products.likes{
                        CompareProductsItem(title: "Likes", products: likes)
                    }
                    if let sugars = products.sugar{
                        CompareProductsItem(title: "Sugar compare", products: sugars)
                    }
                    if let proteins = products.protein{
                        CompareProductsItem(title: "Protein", products: proteins)
                    }
                    if let calories = products.calories{
                        CompareProductsItem(title: "Calories", products: calories)
                    }
                }
                .navigationTitle("Compared products")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchProducts)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct ComparableProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ComparableProductsView(vm: ComparableProductsViewModel(upc: ""))
    }
}

struct CompareProductsItem: View{
    var title: String
    var products: [ComparedInfo]
    var body: some View{
        Section {
            List{
                ForEach(products, id: \.id) { product in
                    Text(product.title ?? "")
                        .font(.title2)
                    AsyncImage(url: URL(string: product.image ?? ""))
                    Text("Compar score: \(product.difference ?? 0)")
                }
            }
        } header: {
            Text(title)
        }

    }
}
