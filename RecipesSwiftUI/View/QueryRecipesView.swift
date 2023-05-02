//
//  QueryRecipesView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/2/23.
//

import SwiftUI

struct QueryRecipesView: View {
    @ObservedObject var vm: QueryRecipesViewModel
    
    var body: some View {
        ZStack{
            if let recipes = vm.recipes?.results{
                List{
                    ForEach(recipes, id: \.id) { recipe in
                        recipeItem(recipe: recipe)
                    }
                }
                .listStyle(.plain)
                .navigationTitle(vm.query)
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchRecipes)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct QueryRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        QueryRecipesView(vm: QueryRecipesViewModel(query: ""))
    }
}

struct recipeItem: View{
    var recipe: RapidRecipe
    var body: some View{
        VStack{
            Text(recipe.title ?? "")
                .font(.title3)
            AsyncImage(url: URL(string: recipe.image!))
        }
    }
}
