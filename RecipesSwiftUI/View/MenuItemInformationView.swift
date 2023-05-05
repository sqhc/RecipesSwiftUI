//
//  MenuItemInformationView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/5/23.
//

import SwiftUI

struct MenuItemInformationView: View {
    @StateObject var vm: MenuItemInformationViewModel
    
    var body: some View {
        ZStack{
            if let information = vm.info{
                VStack{
                    Text(information.title ?? "")
                        .font(.title2)
                    AsyncImage(url: URL(string: information.image ?? ""))
                    Text("Restaurant: \(information.restaurantChain ?? "")")
                    if let nutrients = information.nutrition?.nutrients{
                        Section {
                            List{
                                ForEach(nutrients, id: \.name) { nutrient in
                                    Text("\(nutrient.amount ?? 0.0) \(nutrient.unit ?? "")  \(nutrient.name ?? "") ")
                                }
                            }
                            .listStyle(.plain)
                        } header: {
                            Text("Nntritions")
                        }

                    }
                }
                .navigationTitle("Menu item information")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchInformation)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct MenuItemInformationView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemInformationView(vm: MenuItemInformationViewModel(id: 0))
    }
}
