//
//  MoviesDataSource.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation
import UIKit

protocol PassingDataProtocol {
    func fetchMovieByIndexpath(indexpath: IndexPath)
}

class MoviesDataSource: NSObject {
    var movieSearchBar: UISearchBar
    var selectedMovieGenre: [Int] = []
    private var moviesTableView: UITableView
    private var moviesViewModel: MovieListViewModel
    var moviesList: [MovieViewModel] = []
    var passingDataDelegate: PassingDataProtocol!
    var movieId: Int = 0
    
    init(
        moviesTableView: UITableView, moviesViewModel: MovieListViewModel, movieSearchBar: UISearchBar
    ) {
        self.moviesTableView = moviesTableView
        self.moviesViewModel = moviesViewModel
        self.movieSearchBar = movieSearchBar
        super.init()
        setUpDelegates()
    }
    
    private func setUpDelegates() {
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
    }
    func refresh(url: String, movieSearchBar: UISearchBar,completion : @escaping ()-> Void) {
        moviesViewModel.getList(
            url: url,query: ["query" : movieSearchBar.text ?? ""] ,
            completion: { [weak self] movie in
                self!.moviesList = movie
                self!.moviesTableView.reloadData()
                completion()
            })
    }
    
}

// MARK: -DataSource class extensions

extension MoviesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("top rated \(moviesList[indexPath.row].title)")
        passingDataDelegate.fetchMovieByIndexpath(indexpath: indexPath)
        selectedMovieGenre = moviesList[indexPath.row].id
        print(selectedMovieGenre)
        movieId = moviesList[indexPath.row].movieID
        print(movieId)
    }
}
extension MoviesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = moviesList[indexPath.row]
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
                as? MoviesTableViewCell
        else {
            fatalError("Cannot dequeue cell with identifier: MovieCell")
        }
        
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
}


