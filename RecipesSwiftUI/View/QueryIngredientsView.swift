//
//  QueryIngredientsView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import SwiftUI

struct QueryIngredientsView: View {
    @StateObject var vm: QueryIngredientsViewModel
    var body: some View {
        ZStack{
            if let ingredients = vm.ingredients?.results{
                List{
                    ForEach(ingredients, id: \.id) { ingredient in
                        ShowIngredientItem(ingredient: ingredient)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Ingredients")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchIngredients)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct QueryIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        QueryIngredientsView(vm: QueryIngredientsViewModel(query: "", number: 10))
    }
}

struct ShowIngredientItem: View{
    var ingredient: RapidIngredient
    var body: some View{
        VStack{
            Text(ingredient.name ?? "")
            NavigationLink("Information") {
                IngredientInformationView(vm: IngredientInformationViewModel(id: ingredient.id ?? 0))
            }
        }
    }
}
