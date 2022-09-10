//
//  MoviesViewController.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import UIKit
import Cosmos
import TinyConstraints


class MoviesViewController: UIViewController {
    
    //    MARK: - Outlets
    @IBOutlet weak var searchMovie: UISearchBar!
    @IBOutlet weak var popularLabel: UIButton!
    @IBOutlet weak var topRatedLabel: UIButton!
    @IBOutlet weak var nowPlayingLabel: UIButton!
    @IBOutlet weak var moviesTableView: UITableView!
    
    //   MARK: - Components
    private var searchBar : UISearchBar!
    private var viewModel: MovieListViewModelProtocol!
    private var dataSource: MoviesDataSource!
    private var moviesManager: MoviesManagerProtocol!
    private var searchBarDelegate : UISearchResultsUpdating!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designButton()
        configureViewModel()
        dataSource.refresh(url: Links.baseUrl.rawValue + "now_playing")
        moviesTableView.refreshControl = UIRefreshControl()
        dataSource.passingDataDelegate = self
    }
    func designButton(){
        popularLabel.layer.cornerRadius = 10
        nowPlayingLabel.layer.cornerRadius = 10
        topRatedLabel.layer.cornerRadius = 10
    }
    //    MARK: - Set Up functions
    
    private func configureMovie(){
        moviesManager = MoviesManager()
        viewModel = MovieListViewModel(with: moviesManager)
    }
    private func configureViewModel() {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: Links.baseUrl.rawValue + "now_playing", movieSearchBar: searchMovie)
    }
    //    MARK: - Action Buttons
    @IBAction func popularButtonDidTap(_ sender: Any) {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: Links.baseUrl.rawValue + "popular", movieSearchBar: searchMovie)
        dataSource.refresh(url: Links.baseUrl.rawValue + "popular")
        dataSource.passingDataDelegate = self
        
    }
    @IBAction func topRatedButtonDidTap(_ sender: Any) {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: Links.baseUrl.rawValue + "top_rated", movieSearchBar: searchMovie)
        dataSource.passingDataDelegate = self
        dataSource.refresh(url: Links.baseUrl.rawValue + "top_rated")
    }
    
    @IBAction func nowPlayingButtonDidTap(_ sender: Any) {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: Links.baseUrl.rawValue + "now_playing", movieSearchBar: searchMovie)
        print("print",self)
        dataSource.passingDataDelegate = self
        dataSource.refresh(url: Links.baseUrl.rawValue + "now_playing")
    }
    
}


//MARK: extension for complete passing data protocol

extension MoviesViewController : PassingDataProtocol {
    func fetchMovie(indexpath: IndexPath) {
        performSegue(withIdentifier: "DetailPage", sender: indexpath)
    }
    //    MARK: function for implemeting cell's fileds
    
    func dataTransfer(item : MovieViewModel,segue: UIStoryboardSegue) {
        
        let destinationVC = segue.destination as? MovieDetailViewController
        destinationVC?.movieImdbField = String(item.imdb)
        destinationVC?.movieNameFiled = String(item.title)
        destinationVC?.movieOverviewField = String(item.overview)
        destinationVC?.movieRateField = item.imdb / 2
        destinationVC?.movieImageField = item.posterPath
        destinationVC?.selectedMovieGenres = item.id
        destinationVC?.moviesId = item.movieID
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailPage" {
            let indexPath = sender as! IndexPath
            if dataSource.searching {
                dataTransfer(item: dataSource.filteredMovies[indexPath.row],
                             segue: segue)
            }
            else {
                dataTransfer(item: dataSource.moviesList[indexPath.row], segue: segue)
            }
        }
    }
    
}
