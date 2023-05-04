//
//  IngredientInformationView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import SwiftUI

struct IngredientInformationView: View {
    @StateObject var vm: IngredientInformationViewModel
    var body: some View {
        ZStack{
            if let info = vm.ingredientInformation{
                VStack{
                    Text(info.name ?? "")
                        .font(.title)
                    Text("Consistency: \(info.consistency ?? "")")
                    if let units = info.possibleUnits{
                        Section {
                            List{
                                ForEach(units, id: \.self) { unit in
                                    Text(unit)
                                }
                            }
                            .listStyle(.plain)
                        } header: {
                            Text("Units")
                        }
                    }
                    
                    if let shoppingUnits = info.shoppingListUnits{
                        Section{
                            List{
                                ForEach(shoppingUnits, id: \.self) { unit in
                                    Text(unit)
                                }
                            }
                            .listStyle(.plain)
                        } header: {
                            Text("Shoping units")
                        }
                    }
                    
                    if let catogories = info.categoryPath{
                        Section {
                            List{
                                ForEach(catogories, id: \.self) { category in
                                    Text(category)
                                }
                            }
                            .listStyle(.plain)
                        } header: {
                            Text("Categories")
                        }

                    }
                }
                .navigationTitle("Ingredient information")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchInfo)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct IngredientInformationView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientInformationView(vm: IngredientInformationViewModel(id: 0))
    }
}
