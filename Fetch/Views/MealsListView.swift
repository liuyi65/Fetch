//
//  MealsListView.swift
//  Fetch
//
//  Created by Liu Yi on 11/6/23.
//
import SwiftUI
@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            MealsListView()
        }
    }
}
struct MealsListView: View {
    @State private var meals: [Meal] = []
    @State private var isLoading = false
    @State private var alertItem: AlertItem?
    
    
    
    
    var body: some View {
        VStack{
            NavigationView {
                
                List(meals.sorted { $0.strMeal ?? "" < $1.strMeal ?? "" }, id: \.id) { meal in
                    NavigationLink(destination: MealDetailView(mealID: meal.idMeal ?? "")) {
                        Text(meal.strMeal ?? "Unknown Dessert")
                    }
                }
                .navigationTitle("Desserts")
                .onAppear(perform: loadMeals)
                .overlay {
                    if isLoading {
                        ProgressView("Loading...")
                    }
                }
                .alert(item: $alertItem) { item in
                    Alert(title: Text(item.title), message: Text(item.message), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    private func loadMeals() {
        isLoading = true
        NetworkingManager.shared.fetchDesserts { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedMeals):
                    self.meals = fetchedMeals
                case .failure(let error):
                    alertItem = AlertItem(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
}

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}



