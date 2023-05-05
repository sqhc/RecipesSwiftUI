//
//  SearchProductsView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import SwiftUI

struct SearchProductsView: View {
    @StateObject var vm = SearchProductsViewModel()
    
    var body: some View {
        VStack{
            QuerySearchProductsItem()
            Divider()
            AutoCompleteProductSearchItem()
        }
        .environmentObject(vm)
        .navigationTitle("Search for products")
    }
}

struct SearchProductsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchProductsView()
    }
}

struct QuerySearchProductsItem: View{
    @EnvironmentObject var vm: SearchProductsViewModel
    var body: some View{
        VStack{
            Text("Search with query")
                .font(.title2)
            TextField("Query", text: $vm.query)
                .background(Color.gray.opacity(0.3).cornerRadius(20))
                .padding(10)
            Stepper(value: $vm.number, in: 1...100) {
                Text("Number of products: \(vm.number)")
            }
            NavigationLink("Search products") {
                QueryProductsView(vm: QueryProductsViewModel(query: vm.query, number: vm.number))
            }
        }
    }
}

struct AutoCompleteProductSearchItem: View{
    @EnvironmentObject var vm: SearchProductsViewModel
    var body: some View{
        VStack{
            Text("Auto complete Search")
                .font(.title2)
            TextField("Partial query", text: $vm.autocomplete)
                .background(Color.gray.opacity(0.3).cornerRadius(20))
                .padding(10)
            NavigationLink("Auto complet products") {
                AutoCompleteProductsView(vm: AutoCompleteProductsViewModel(query: vm.autocomplete, number: vm.number))
            }
        }
    }
}
