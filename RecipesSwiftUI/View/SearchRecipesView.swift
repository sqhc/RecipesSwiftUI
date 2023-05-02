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
            RecipeQuery(vm: vm)
        }
        .navigationTitle("Search recipes")
    }
}

struct SearchRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecipesView()
    }
}

struct RecipeQuery: View{
    @StateObject var vm: SearchRecipesViewModel
    var body: some View{
        VStack{
            Text("Search by query")
                .font(.title2)
            TextField("Query", text: $vm.query)
                .background(Color.gray.opacity(0.3).cornerRadius(20))
                .padding(10)
        }
    }
}
