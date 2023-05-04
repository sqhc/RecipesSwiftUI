//
//  AutoCompleteIngredientsView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import SwiftUI

struct AutoCompleteIngredientsView: View {
    @StateObject var vm: AutoCompleteIngredientsViewModel
    var body: some View {
        ZStack{
            if let ingredients = vm.ingredients{
                List{
                    ForEach(ingredients, id: \.name) { ingredient in
                        Text(ingredient.name ?? "")
                    }
                    .listStyle(.plain)
                    .navigationTitle("Auto complete ingredients")
                }
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchIngredients)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cacnel")
            }

        }
    }
}

struct AutoCompleteIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        AutoCompleteIngredientsView(vm: AutoCompleteIngredientsViewModel(query: "", number: 0))
    }
}
