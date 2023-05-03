//
//  RecipeInfoDataModel.swift
//  RecipesSwiftUI
//
//  Created by 沈清昊 on 5/2/23.
//

import Foundation

struct RecipeInfo: Codable{
    let extendedIngredients: [RecipeIngredient]?
    let title: String?
    let readyInMinutes: Int?
    let image: String?
    let summary: String?
    let analyzedInstructions: [RecipeInstruction]?
}

struct RecipeIngredient: Codable{
    let id: Int?
    let aisle: String?
    let consistency: String?
    let original: String?
    let amount: Double?
    let unit: String?
}

struct RecipeInstruction: Codable{
    let name: String?
    let steps: [InstructionStep]?
}

struct InstructionStep: Codable{
    let number: Int?
    let step: String?
    let ingredients: [StepIngredient]?
    let equipment: [StepEquipment]?
    let length: StepLength?
}

struct StepIngredient: Codable{
    let id: Int?
    let name: String?
}

struct StepEquipment: Codable{
    let id: Int?
    let name: String?
}

struct StepLength: Codable{
    let number: Int?
    let unit: String?
}
