//
//  ListProtocol.swift
//  PersonalMovieApp
//
//  Created by APPLE on 16.09.22.
//

import Foundation

protocol MovieListViewModelProtocol: AnyObject {
    associatedtype T
    
    func getList(url : String,completion: @escaping (([T]) -> Void))
    
    init(with moviesManager: TaskManagerProtocol)
}
