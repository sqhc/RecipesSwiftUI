//
//  AutoCompleteProductsView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import SwiftUI

struct AutoCompleteProductsView: View {
    @ObservedObject var vm: AutoCompleteProductsViewModel
    
    var body: some View {
        ZStack{
            if let products = vm.products?.results{
                List{
                    ForEach(products, id: \.id) { product in
                        Text(product.title ?? "")
                        NavigationLink("Information") {
                            ProductInformationView(vm: ProductInformationViewModel(id: product.id ?? 0))
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Autocomplete products")
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

struct AutoCompleteProductsView_Previews: PreviewProvider {
    static var previews: some View {
        AutoCompleteProductsView(vm: AutoCompleteProductsViewModel(query: "", number: 10))
    }
}
