//
//  IngredientsRecipesView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/3/23.
//

import SwiftUI

struct IngredientsRecipesView: View {
    @StateObject var vm: IngredientsRecipesViewModel
    
    var body: some View {
        ZStack{
            if let recipes = vm.recipes{
                List{
                    ForEach(recipes, id: \.id) { recipe in
                        IngredientRecipeItem(recipe: recipe)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Recipes by ingredients")
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

struct IngredientsRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsRecipesView(vm: IngredientsRecipesViewModel(ingredients: "", number: 5))
    }
}

struct IngredientRecipeItem: View{
    var recipe: RecipeFromIngredient
    var body: some View{
        VStack{
            Text(recipe.title ?? "")
                .font(.title2)
            AsyncImage(url: URL(string: recipe.image ?? ""))
            HStack{
                Image(systemName: "hand.thumbsup")
                Text(" \(recipe.likes ?? 0)")
            }
            if let ingredients = recipe.usedIngredients{
                Section {
                    ForEach(ingredients, id: \.id) { ingred in
                        VStack{
                            Text(ingred.aisle ?? "")
                                .font(.title3)
                            Text(ingred.original ?? "")
                            AsyncImage(url: URL(string: ingred.image ?? ""))
                        }
                    }
                } header: {
                    Text("Ingredients")
                }
            }
            NavigationLink("Information") {
                RecipeInformationView(vm: RecipeInformationViewModel(id: recipe.id ?? 0))
            }
            Divider()
            Spacer()
            NavigationLink("Similar recipes") {
                SimilarRecipesView(vm: SimilarRecipesViewModel(id: recipe.id ?? 0))
            }
        }
    }
}

