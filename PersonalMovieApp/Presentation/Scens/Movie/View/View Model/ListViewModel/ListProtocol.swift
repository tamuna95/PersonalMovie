//
//  ListProtocol.swift
//  PersonalMovieApp
//
//  Created by APPLE on 16.09.22.
//

import Foundation

protocol ListViewModelProtocol: AnyObject {
    associatedtype T
    
    func getList(url : String,completion: @escaping (([T]) -> Void))
    func getList(url : String, query: [String : String],completion: @escaping (([T]) -> Void))
    init(with moviesManager: TaskManagerProtocol)
}
