//
//  ContentView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Recipes")
                    .font(.title)
                NavigationLink("Search recipes") {
                    SearchRecipesView()
                }
                Divider()
                Text("Ingredients")
                    .font(.title)
                NavigationLink("Search ingredients") {
                    SearchIngredientsView()
                }
                Divider()
                Text("Products")
                    .font(.title)
                NavigationLink("Search products") {
                    SearchProductsView()
                }
            }
            .navigationTitle("Search options")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
