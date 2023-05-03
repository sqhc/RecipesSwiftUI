//
//  SimilarRecipesView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/3/23.
//

import SwiftUI

struct SimilarRecipesView: View {
    @StateObject var vm: SimilarRecipesViewModel
    
    var body: some View {
        ZStack{
            if let similars = vm.similars{
                List{
                    ForEach(similars, id: \.id) {similar in
                        SimilarItem(similar: similar)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Similar recipes")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchSimilars)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct SimilarRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarRecipesView(vm: SimilarRecipesViewModel(id: 0))
    }
}

struct SimilarItem: View{
    var similar: SimilarRecipe
    var body: some View{
        VStack{
            Text(similar.title ?? "")
            Text("Ready in \(similar.readyInMinutes ?? 0)")
            Text("Serving \(similar.servings ?? 0) people")
            NavigationLink("Information") {
                RecipeInformationView(vm: RecipeInformationViewModel(id: similar.id ?? 0))
            }
        }
    }
}
