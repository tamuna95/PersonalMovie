//
//  MoviesViewController.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Cosmos
import UIKit

class MoviesViewController: UIViewController,UISearchBarDelegate {
    
    //    MARK: - Outlets
    @IBOutlet weak var searchMovie: UISearchBar!
    @IBOutlet weak var popularLabel: UIButton!
    @IBOutlet weak var topRatedLabel: UIButton!
    @IBOutlet weak var nowPlayingLabel: UIButton!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            loadingView.layer.cornerRadius = 3
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //   MARK: - Components
    private var searchBar: UISearchBar!
    private var viewModel: MovieListViewModel!
    private var dataSource: MoviesDataSource!
    private var moviesManager: TaskManagerProtocol!
    private var searchBarDelegate: UISearchResultsUpdating!
    
    override func viewDidLoad() {
        moviesManager = TaskManager()
        viewModel = MovieListViewModel(with: moviesManager)
        dataSource = MoviesDataSource(
            moviesTableView: moviesTableView, moviesViewModel: viewModel, movieSearchBar: searchMovie)
        designButton()
        showSpinner()
        dataSource.refresh(url: Links.baseUrl.rawValue + "now_playing",
                           movieSearchBar: searchMovie, completion: self.hideSpinner)
        dataSource.passingDataDelegate = self
        searchMovie.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        showSpinner()
        if searchMovie.text == "" ||  searchMovie.text == nil {
            dataSource.refresh(url: Links.baseUrl.rawValue + "now_playing", movieSearchBar: searchBar, completion: self.hideSpinner)
        }
        else {
            dataSource.refresh(url: Links.searchMovie.rawValue,
                               movieSearchBar: searchBar, completion: self.hideSpinner)
        }
        
    }
    //    MARK: private functions
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }
    
    private func hideSpinner() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
    
    private func designButton() {
        popularLabel.layer.cornerRadius = 10
        nowPlayingLabel.layer.cornerRadius = 10
        topRatedLabel.layer.cornerRadius = 10
    }
    
    //    MARK: - Action Buttons
    @IBAction func popularButtonDidTap(_ sender: Any) {
        showSpinner()
        dataSource.refresh(url: Links.baseUrl.rawValue + "popular",
                           movieSearchBar: searchMovie, completion: self.hideSpinner)
        searchMovie.text = ""
    }
    
    @IBAction func topRatedButtonDidTap(_ sender: Any) {
        showSpinner()
        dataSource.refresh(url: Links.baseUrl.rawValue + "top_rated",
                           movieSearchBar: searchMovie, completion : self.hideSpinner)
        searchMovie.text = ""
        
    }
    
    @IBAction func upcomingButtonDidTap(_ sender: Any) {
        showSpinner()
        dataSource.refresh(url: Links.baseUrl.rawValue + "upcoming",
                           movieSearchBar: searchMovie, completion: self.hideSpinner)
        searchMovie.text = ""
        
    }
}

//MARK: extension for complete passing data protocol

extension MoviesViewController: PassingDataProtocol {
    func fetchMovieByIndexpath(indexpath: IndexPath) {
        performSegue(withIdentifier: "DetailPage", sender: indexpath)
    }
    
    func dataTransfer(item: MovieViewModel, segue: UIStoryboardSegue) {
        
        let destinationVC = segue.destination as? MovieDetailViewController
        destinationVC?.movieImdbField = String(item.imdb)
        destinationVC?.movieNameFiled = String(item.title)
        destinationVC?.movieOverviewField = String(item.overview)
        destinationVC?.movieRateField = item.imdb / 2
        destinationVC?.movieImageField = item.posterPath
        destinationVC?.selectedMovieGenres = item.id
        destinationVC?.moviesId = item.movieID
        destinationVC?.movieViewModel = item
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailPage" {
            let indexPath = sender as! IndexPath
            dataTransfer(item: dataSource.moviesList[indexPath.row], segue: segue)
            
        }
    }
    
}
