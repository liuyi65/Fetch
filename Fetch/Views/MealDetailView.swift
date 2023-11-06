//
//  MealDetailView.swift
//  Fetch
//
//  Created by Liu Yi on 11/6/23.
//

import SwiftUI

struct MealDetailView: View {
    let mealID: String
    
    @State private var mealDetail: MealDetail?
    @State private var isLoading = false
    @State private var alertItem: AlertItem?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Meal Name: ")
                    .font(.headline)
                    .padding(.bottom, 2)
                Text(mealDetail?.strMeal ?? "Unknown Dessert")
                    .font(.system(size:14))
                    
                Text("Instructions: ")
                    .font(.headline)
                    .padding(.bottom, 2)
                Text(mealDetail?.strInstructions ?? "")
                    .font(.system(size:14))

                Group {
                    Text("Ingredients:").font(.headline)
                    ForEach(mealDetail?.ingredients ?? [], id: \.ingredient) { ingredient, measurement in
                        Text("\(ingredient): \(measurement)").font(.body)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(mealDetail?.strMeal ?? "Loading")
        .onAppear(perform: loadMealDetail)
        .overlay {
            if isLoading {
                ProgressView("Loading...")
            }
        }
        .alert(item: $alertItem) { item in
            Alert(title: Text(item.title), message: Text(item.message), dismissButton: .default(Text("OK")))
        }
    }
    
    
    
    private func loadMealDetail() {
        isLoading = true
        NetworkingManager.shared.fetchMealDetails(mealID: mealID) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let detail):
                    
                    self.mealDetail = detail
                    
                case .failure(let error):
                    alertItem = AlertItem(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
}


