//
//  IngredientSubstitutesView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import SwiftUI

struct IngredientSubstitutesView: View {
    @StateObject var vm: IngredientSubstitutesViewModel
    var body: some View {
        ZStack{
            if let substitutes = vm.substitutes{
                VStack{
                    if let subs = substitutes.substitutes{
                        List{
                            ForEach(subs, id: \.self) {sub in
                                Text(sub)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .navigationTitle("\(substitutes.ingredient ?? "")'s substitutes")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchSubstitutes)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct IngredientSubstitutesView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSubstitutesView(vm: IngredientSubstitutesViewModel(id: 0))
    }
}
