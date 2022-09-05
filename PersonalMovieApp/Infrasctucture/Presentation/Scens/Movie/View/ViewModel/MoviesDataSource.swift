//
//  MoviesDataSource.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation
import UIKit

protocol passingDataProtocol {
    func fetchMovie(indexpath : IndexPath)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}


class MoviesDataSource : NSObject {
    var movieSearchBar : UISearchBar
    var selectedMovieGenre : [Int] = []
    private var moviesTableView: UITableView
    private var moviesViewModel: MovieListViewModelProtocol
    var moviesList: [MovieViewModel] = []
    private var urlItems : String
    var filteredMovies: [MovieViewModel] = []
    var searching = false
    var passingDataDelegate : passingDataProtocol!
    var movieId : Int = 0
    
    
    init(moviesTableView: UITableView, moviesViewModel: MovieListViewModelProtocol,urlItems : String,movieSearchBar : UISearchBar){
        self.moviesTableView = moviesTableView
        self.moviesViewModel = moviesViewModel
        self.urlItems = urlItems
        self.movieSearchBar = movieSearchBar
        super.init()
        setUpDelegates()
    }
    
    private func setUpDelegates() {
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
        
    }
    
    func refresh(url : String) {
        moviesViewModel.getList(url: url, completion: { movie in
            self.moviesList.append(contentsOf: movie)
            self.moviesTableView.reloadData()
        })
    }
}

// MARK :- DataSource class extensions

extension MoviesDataSource : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("top rated \(moviesList[indexPath.row].title)")
        passingDataDelegate.fetchMovie(indexpath: indexPath)
        selectedMovieGenre = moviesList[indexPath.row].id
        print(selectedMovieGenre)
        movieId = moviesList[indexPath.row].movieID
    }
}

extension MoviesDataSource : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredMovies.count
        }
        else {
            return moviesList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var movie = moviesList[indexPath.row]
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MoviesTableViewCell
        else {
            fatalError("Cannot dequeue cell with identifier: MovieCell")
        }
        if searching {
            movie = filteredMovies[indexPath.row]
            cell.configure(with: movie)
            
        }
        cell.configure(with: movie)
        movieSearchBar.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
}

//MARK :- Protocol for Search Bar
extension MoviesDataSource : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = moviesList.filter{$0.title.prefix(searchText.count) == searchText}
        print(filteredMovies)
        searching = true
        moviesTableView.reloadData()
    }
    
}
