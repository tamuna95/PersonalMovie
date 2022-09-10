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
    private var indexPathArry = [IndexPath]()

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

extension MoviesViewController : passingDataProtocol {
    func fetchMovie(indexpath: IndexPath) {
        indexPathArry.append(indexpath)
        performSegue(withIdentifier: "DetailPage", sender: nil)
    }
//    MARK: function for implemeting cell's fileds
    
    func dataTransfer(array : [MovieViewModel],segue: UIStoryboardSegue) {
        if segue.identifier == "DetailPage" {
        let destinationVC = segue.destination as? MovieDetailViewController
            for i in indexPathArry {
                destinationVC?.movieImdbField = String(array[i.row].imdb)
                destinationVC?.movieNameFiled = String(array[i.row].title)
                destinationVC?.movieOverviewField = String(array[i.row].overview)
                destinationVC?.movieRateField = array[i.row].imdb / 2
                destinationVC?.movieImageField = array[i.row].posterPath
                destinationVC?.selectedMovieGenres = array[i.row].id
                destinationVC?.moviesId = array[i.row].movieID
                
    }
}
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if dataSource.searching {
                dataTransfer(array: dataSource.filteredMovies, segue: segue)
            }
            else {
                dataTransfer(array: dataSource.moviesList, segue: segue)
                }
        }
    
}
