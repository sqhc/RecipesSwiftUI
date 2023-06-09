//
//  QueryRecipesView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/2/23.
//

import SwiftUI

struct QueryRecipesView: View {
    @StateObject var vm: QueryRecipesViewModel
    @State private var appeared = false
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
        .onAppear(perform: {
            guard !appeared else {return}
            appeared.toggle()
            vm.fetchRecipes()
        })
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
