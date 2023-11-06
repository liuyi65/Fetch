//
//  NetworkingManager.swift
//  Fetch
//
//  Created by Liu Yi on 11/6/23.
//

import Foundation

class RecipeApiManager {
    static let shared = RecipeApiManager()
    private init() {}
    
    private let baseURLString = "https://www.themealdb.com/api/json/v1/1"
    private let session = URLSession.shared
    
    //find Dessert category
    func fetchDesserts(completion: @escaping (Result<[Meal], Error>) -> Void) {
        let dessertsURLString = "\(baseURLString)/filter.php?c=Dessert"
        
        guard let url = URL(string: dessertsURLString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
        
            //Decode to json
            do {
                let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
                completion(.success(mealsResponse.meals))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMealDetails(mealID: String, completion: @escaping (Result<MealDetail, Error>) -> Void) {
        let detailsURLString = "\(baseURLString)/lookup.php?i=\(mealID)"
        
        guard let url = URL(string: detailsURLString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do {
                let detailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                if let details = detailResponse.meals.first {
                    completion(.success(details))
                } else {
                    completion(.failure(URLError(.cannotParseResponse)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
