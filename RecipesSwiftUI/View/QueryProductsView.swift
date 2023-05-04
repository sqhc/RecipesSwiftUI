//
//  QueryProductsView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import SwiftUI

struct QueryProductsView: View {
    @StateObject var vm: QueryProductsViewModel
    var body: some View {
        ZStack{
            if let products = vm.products?.products{
                List{
                    ForEach(products, id: \.id) { product in
                        ProductItem(product: product)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Products")
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

struct QueryProductsView_Previews: PreviewProvider {
    static var previews: some View {
        QueryProductsView(vm: QueryProductsViewModel(query: "", number: 10))
    }
}

struct ProductItem: View{
    var product: RapidProduct
    var body: some View{
        VStack{
            Text(product.title ?? "")
                .font(.title3)
            AsyncImage(url: URL(string: product.image ?? ""))
        }
    }
}
