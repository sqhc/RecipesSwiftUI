//
//  RecipeInformationView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/2/23.
//

import SwiftUI

struct RecipeInformationView: View {
    @StateObject var vm: RecipeInformationViewModel
    
    var body: some View {
        ZStack{
            if let info = vm.info{
                List{
                    Text(info.title ?? "")
                        .font(.title)
                    Text("Cooking time: \(info.readyInMinutes ?? 0) minutes")
                    AsyncImage(url: URL(string: info.image ?? ""))
                    Text(info.summary ?? "")
                    Section {
                        if let ingredients = info.extendedIngredients{
                            ForEach(ingredients, id: \.id) { ingredient in
                                IngredientItem(ingredient: ingredient)
                            }
                        }
                    } header: {
                        Text("Ingredients")
                    }

                    Section {
                        if let instructions = info.analyzedInstructions{
                            ForEach(instructions, id: \.name) { instruction in
                                Text(instruction.name ?? "")
                                if let steps = instruction.steps{
                                    ForEach(steps, id: \.number) {step in
                                        InstructionStepItem(step: step)
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Instructions and steps")
                    }

                }
                .navigationTitle("Information")
                .listStyle(.plain)
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

struct RecipeInformationView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInformationView(vm: RecipeInformationViewModel(id: 0))
    }
}

struct IngredientItem: View{
    var ingredient: RecipeIngredient
    var body: some View{
        VStack{
            Text(ingredient.aisle ?? "")
                .font(.title2)
            Text("Consistency: \(ingredient.consistency ?? "")")
            Text(ingredient.original ?? "")
            Text("Amount: \(ingredient.amount ?? 0.0) \(ingredient.unit ?? "")")
        }
    }
}

struct InstructionStepItem: View{
    var step: InstructionStep
    var body: some View{
        VStack{
            Text("\(step.number ?? 0).")
            Text(step.step ?? "")
            Text("\(step.length?.number ?? 0) \(step.length?.unit ?? "")")
            Text("Ingredients:")
            if let ins = step.ingredients{
                ForEach(ins, id: \.id) { i in
                    Text(i.name ?? "")
                }
            }
            Text("Equipments:")
            if let equips = step.equipment{
                ForEach(equips, id: \.id) { equip in
                    Text(equip.name ?? "")
                }
            }
        }
    }
}
