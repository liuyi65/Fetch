//
//  Meal.swift
//  Fetch
//
//  Created by Liu Yi on 11/6/23.
//

import Foundation

struct Meal: Codable, Identifiable {
    let idMeal: String?
    let strMeal: String?
    var id: String { idMeal ?? UUID().uuidString }
}

struct MealDetail: Codable {
    let idMeal: String?
    let strMeal: String?
    let strInstructions: String?
    
    // Properties for ingredients at most 20
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?

    // Properties for measurements at most 20
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?

    // Exclude empty variables
    var ingredients: [(ingredient: String, measurement: String)] {
        var ingredientsArray: [(ingredient: String, measurement: String)] = []
        
        //make a connection between ingredient and measure
        func value(forKey key: String) -> Any? {
            let mirror = Mirror(reflecting: self)
            return mirror.children.first { $0.label == key }?.value
        }
        
        
        for i in 1...20 {
            if let ingredient = value(forKey: "strIngredient\(i)") as? String, !ingredient.isEmpty,
               let measurement = value(forKey: "strMeasure\(i)") as? String, !measurement.isEmpty {
                ingredientsArray.append((ingredient, measurement))
            } else {
                //when encounter an empty variable, stop looping
                break
            }
        }
        
        return ingredientsArray
    }
}


struct MealsResponse: Codable {
    let meals: [Meal]
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}
