//
//  MoviesDataSource.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation
import UIKit

class MoviesDataSource : NSObject{
    
    private var moviesTableView: UITableView
    private var moviesViewModel: MovieListViewModelProtocol
    private var moviesList: [MovieViewModel] = []
    private var topRatedMovieList : [MovieViewModel] = []
    private var nowPlayingMovieList : [MovieViewModel] = []
    private var popularMovieList : [MovieViewModel] = []
    private var urlItems : String
    
    init(moviesTableView: UITableView, moviesViewModel: MovieListViewModelProtocol,urlItems : String){
        self.moviesTableView = moviesTableView
        self.moviesViewModel = moviesViewModel
        self.urlItems = urlItems

        super.init()
        setUpDelegates()
    }
    
    private func setUpDelegates() {
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
    }
    
     func refresh() {
        moviesViewModel.getMoviesList(url: urlItems, completion: { movie in
            self.moviesList.append(contentsOf: movie)
            self.moviesTableView.reloadData()
        })
    }
    
    func getMovies(){
        
    }
    func getTopRatedMovieList(){
        moviesViewModel.getMoviesList(url: urlItems,completion: { movie in
            self.moviesList = self.topRatedMovieList
            self.moviesList.append(contentsOf: movie)
            self.moviesTableView.reloadData()
            print(self.moviesList.first?.title)
        })
        
        
    }
    
//    func getMovies(with array: [MovieViewModel]){
//        moviesViewModel.getMoviesList(url: urlItems,completion: { movie in
//            self.moviesList = array
//            self.moviesList.append(contentsOf: movie)
//            self.moviesTableView.reloadData()
//            print(self.moviesList.first?.title)
//    })
//    }
    
    func getPopularMovieList(){
        moviesViewModel.getMoviesList(url: urlItems,completion: { movie in
            self.moviesList = self.popularMovieList
            self.moviesList.append(contentsOf: movie)
            self.moviesTableView.reloadData()
            print(self.moviesList.first?.title)
    })
    }
}

extension MoviesDataSource : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension MoviesDataSource : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = moviesList[indexPath.row]
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MoviesTableViewCell
        else {
            fatalError("Cannot deque cell with identifier: MovieCell")
        }
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    }

