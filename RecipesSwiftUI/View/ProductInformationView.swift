//
//  ProductInformationView.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/4/23.
//

import SwiftUI

struct ProductInformationView: View {
    @StateObject var vm: ProductInformationViewModel
    @State private var appeared = false
    
    var body: some View {
        ZStack{
            if let information = vm.information{
                VStack{
                    Text(information.title ?? "")
                        .font(.title2)
                    AsyncImage(url: URL(string: information.image ?? ""))
                    Text("Price: \(information.price ?? 0.0)")
                    HStack{
                        Image(systemName: "hand.thumbsup")
                        Text("\(information.likes ?? 0)")
                    }
                    Text("Number: \(information.servings?.number ?? 0.0), size: \(information.servings?.size ?? 0.0), unit: \(information.servings?.unit ?? "")")
                    if let nutritions = information.nutrition?.nutrients{
                        Section {
                            List{
                                ForEach(nutritions, id: \.name) { nutrition in
                                    Text("\(nutrition.amount ?? 0.0) \(nutrition.unit ?? "") \(nutrition.name ?? "")")
                                }
                            }
                        } header: {
                            Text("Product nutritions")
                        }
                    }
                    Text(information.ingredientList ?? "")
                    NavigationLink("Comparable products") {
                        ComparableProductsView(vm: ComparableProductsViewModel(upc: information.upc ?? ""))
                    }
                }
                .navigationTitle("Product information")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: {
            guard !appeared else {return}
            appeared.toggle()
            vm.fetchInformation()
        })
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct ProductInformationView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInformationView(vm: ProductInformationViewModel(id: 0))
    }
}

