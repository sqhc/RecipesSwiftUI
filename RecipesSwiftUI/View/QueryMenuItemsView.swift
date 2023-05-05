//
//  QueryMenuItemsView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import SwiftUI

struct QueryMenuItemsView: View {
    @StateObject var vm: QueryMenuItemsViewModel
    var body: some View {
        ZStack{
            if let items = vm.items?.menuItems{
                List{
                    ForEach(items, id: \.id) { item in
                        DisplayQueryMenuItem(item: item)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Menu items")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchMenuItems)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct QueryMenuItemsView_Previews: PreviewProvider {
    static var previews: some View {
        QueryMenuItemsView(vm: QueryMenuItemsViewModel(query: "", number: 10))
    }
}

struct DisplayQueryMenuItem: View{
    var item: RapidMenuItem
    var body: some View{
        VStack{
            Text(item.title ?? "")
                .font(.title2)
            Text("Restaurant: \(item.restaurantChain ?? "")")
            AsyncImage(url: URL(string: item.image ?? ""))
            NavigationLink("Information") {
                MenuItemInformationView(vm: MenuItemInformationViewModel(id: item.id ?? 0))
            }
        }
    }
}
