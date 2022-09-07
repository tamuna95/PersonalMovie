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
        dataSource.refresh(url: Links.movieBaseUrl.rawValue + "now_playing")
        moviesTableView.refreshControl = UIRefreshControl()
        moviesTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        dataSource.passingDataDelegate = self
    }
    func designButton(){
        popularLabel.layer.cornerRadius = 10
        nowPlayingLabel.layer.cornerRadius = 10
        topRatedLabel.layer.cornerRadius = 10
    }
    private func configureMovie(){
        moviesManager = MoviesManager()
        viewModel = MovieListViewModel(with: moviesManager)
    }
    
    @IBAction func popularButtonDidTap(_ sender: Any) {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: Links.movieBaseUrl.rawValue + "popular", movieSearchBar: searchMovie)
        dataSource.refresh(url: Links.movieBaseUrl.rawValue + "popular")
        dataSource.passingDataDelegate = self

        
    }
    @IBAction func topRatedButtonDidTap(_ sender: Any) {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: Links.movieBaseUrl.rawValue + "top_rated", movieSearchBar: searchMovie)
        dataSource.passingDataDelegate = self
        dataSource.refresh(url: Links.movieBaseUrl.rawValue + "top_rated")
    }
    
    @IBAction func nowPlayingButtonDidTap(_ sender: Any) {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: Links.movieBaseUrl.rawValue + "now_playing", movieSearchBar: searchMovie)
        print("print",self)
        dataSource.passingDataDelegate = self
        dataSource.refresh(url: Links.movieBaseUrl.rawValue + "now_playing")
    }
    
    private func configureViewModel() {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: Links.movieBaseUrl.rawValue + "now_playing", movieSearchBar: searchMovie)
    }
    @objc private func didPullToRefresh(){
        print("start refresh")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.moviesTableView.refreshControl?.endRefreshing()
            self.moviesTableView.reloadData()
        }
    }
    
    
}
extension MoviesViewController : passingDataProtocol {
    func fetchMovie(indexpath: IndexPath) {
        indexPathArry.append(indexpath)
        performSegue(withIdentifier: "DetailPage", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailPage" {
            let destinationVC = segue.destination as? MovieDetailViewController
            for i in indexPathArry {
                destinationVC?.movieImdbField = String(dataSource.moviesList[i.row].imdb)
                destinationVC?.movieNameFiled = String(dataSource.moviesList[i.row].title)
                destinationVC?.movieOverviewField = String(dataSource.moviesList[i.row].overview)
                destinationVC?.movieRateField = dataSource.moviesList[i.row].imdb / 2
                destinationVC?.movieImageField = dataSource.moviesList[i.row].posterPath
                destinationVC?.selectedMovieGenres = dataSource.moviesList[i.row].id
                destinationVC?.moviesId = dataSource.moviesList[i.row].movieID
            }
        }
    }
}
