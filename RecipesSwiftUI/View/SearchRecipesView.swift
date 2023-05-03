//
//  SearchRecipesView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/2/23.
//

import SwiftUI

struct SearchRecipesView: View {
    @StateObject var vm = SearchRecipesViewModel()
    
    var body: some View {
        VStack{
            RecipeQuery()
            Divider()
            RecipeIngredients()
        }
        .navigationTitle("Search recipes")
        .environmentObject(vm)
    }
}

struct SearchRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecipesView()
    }
}

struct RecipeQuery: View{
    @EnvironmentObject var vm: SearchRecipesViewModel
    var body: some View{
        VStack{
            Text("Search by query")
                .font(.title2)
            TextField("Query", text: $vm.query)
                .background(Color.gray.opacity(0.3).cornerRadius(20))
                .padding(10)
            NavigationLink("Search recipes with query") {
                QueryRecipesView(vm: QueryRecipesViewModel(query: vm.query))
            }
        }
    }
}

struct RecipeIngredients: View{
    @EnvironmentObject var vm: SearchRecipesViewModel
    
    var body: some View{
        VStack{
            Text("Search by ingredients")
                .font(.title2)
            TextField("Ingredients", text: $vm.ingredients)
                .background(Color.gray.opacity(0.3).cornerRadius(20))
                .padding(10)
            Text("How many recipes do you want?")
                .font(.headline)
            Stepper(value: $vm.number, in: 0...50) {
                Text("Number of recipes")
            }
            NavigationLink("Search recipes with ingreidents") {
                IngredientsRecipesView(vm: IngredientsRecipesViewModel(ingredients: vm.ingredients, number: vm.number))
            }
        }
    }
}
