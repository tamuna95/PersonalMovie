//
//  TaskManager.swift
//  PersonalMovieApp
//
//  Created by APPLE on 11.09.22.
//

import Foundation
protocol TaskManagerProtocol: AnyObject {
    func fetchData<T: Codable>(url : String,completion: @escaping ((T) -> Void))
    func fetchData<T: Codable>(url : String,query: [String:String],completion: @escaping ((T) -> Void))
}

class TaskManager: TaskManagerProtocol {
    func fetchData<T>(url: String, query: [String : String], completion: @escaping ((T) -> Void)) where T : Decodable, T : Encodable {
        NetworkManager.shared.get(url: url,query: query) { (result: Result<T, Error>) in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchData<T: Codable>(url: String,completion: @escaping ((T) -> Void)) {
        fetchData(url: url,query: [:],completion: completion)
    }
}

