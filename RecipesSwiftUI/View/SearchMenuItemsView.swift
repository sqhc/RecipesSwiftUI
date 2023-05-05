//
//  SearchMenuItemsView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import SwiftUI

struct SearchMenuItemsView: View {
    @StateObject var vm = SearchMenuItemsViewModel()
    
    var body: some View {
        VStack{
            QuerySearchMenuIte()
        }
        .environmentObject(vm)
        .navigationTitle("Search for menu items")
    }
}

struct SearchMenuItemsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMenuItemsView()
    }
}

struct QuerySearchMenuIte: View{
    @EnvironmentObject var vm: SearchMenuItemsViewModel
    
    var body: some View{
        VStack{
            Text("Search menu items with query")
                .font(.title2)
            TextField("Query", text: $vm.query)
                .background(Color.gray.opacity(0.3).cornerRadius(20))
                .padding(10)
            Stepper(value: $vm.number, in: 1...100) {
                Text("Number of items: \(vm.number)")
            }
            NavigationLink("Search menu items") {
                QueryMenuItemsView(vm: QueryMenuItemsViewModel(query: vm.query, number: vm.number))
            }
        }
    }
}
