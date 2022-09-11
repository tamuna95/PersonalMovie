//
//  TaskManager.swift
//  PersonalMovieApp
//
//  Created by APPLE on 11.09.22.
//

import Foundation
protocol TaskManagerProtocol: AnyObject {
    func fetchMovies<T: Codable>(url : String,completion: @escaping ((T) -> Void))
}

class TaskManager: TaskManagerProtocol {
    func fetchMovies<T: Codable>(url: String,completion: @escaping ((T) -> Void)) {
        NetworkManager.shared.get(url: url) { (result: Result<T, Error>) in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
}
