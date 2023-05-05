//
//  AutoCompleteMenuItemsView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import SwiftUI

struct AutoCompleteMenuItemsView: View {
    @StateObject var vm: AutoCompleteMenuItemsViewModel
    
    var body: some View {
        ZStack{
            if let items = vm.items?.results{
                List{
                    ForEach(items, id: \.id) { item in
                        VStack {
                            Text(item.title ?? "")
                            NavigationLink("Information") {
                                MenuItemInformationView(vm: MenuItemInformationViewModel(id: item.id ?? 0))
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Autocomplete menus")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchItems)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct AutoCompleteMenuItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AutoCompleteMenuItemsView(vm: AutoCompleteMenuItemsViewModel(query: "", number: 10))
    }
}
