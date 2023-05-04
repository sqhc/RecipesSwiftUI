//
//  SearchIngredientsView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/3/23.
//

import SwiftUI

struct SearchIngredientsView: View {
    @StateObject var vm = SearchIngredientsViewModel()
    
    var body: some View {
        VStack{
            QueryIngredientItem()
        }
        .navigationTitle("Search ingredients")
        .environmentObject(vm)
    }
}

struct SearchIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchIngredientsView()
    }
}

struct QueryIngredientItem: View{
    @EnvironmentObject var vm: SearchIngredientsViewModel
    var body: some View{
        VStack{
            Text("Search by query")
                .font(.title2)
            TextField("Query", text: $vm.query)
                .background(Color.gray.opacity(0.3).cornerRadius(20))
                .padding(10)
            Stepper(value: $vm.number, in: 1...100) {
                Text("Number of ingredients: \(vm.number)")
            }
        }
    }
}
