//
//  MoviesViewController.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var searchMovie: UISearchBar!
    @IBOutlet weak var popularLabel: UIButton!
    @IBOutlet weak var topRatedLabel: UIButton!
    @IBOutlet weak var nowPlayingLabel: UIButton!
    @IBOutlet weak var moviesTableView: UITableView!
    private var searchBar : UISearchBar!
    private var viewModel: MovieListViewModelProtocol!
    private var dataSource: MoviesDataSource!
    private var moviesManager: MoviesManagerProtocol!
    private var searchBarDelegate : UISearchResultsUpdating!
    private var url = UrlItems()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        dataSource.refresh()
        moviesTableView.refreshControl = UIRefreshControl()
        moviesTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    private func configureMovie(){
        moviesManager = MoviesManager()
        viewModel = MovieListViewModel(with: moviesManager)
    }
    
    @IBAction func popularButtonDidTap(_ sender: Any) {
        configureMovie()

        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: url.popular, movieSearchBar: searchMovie)
        dataSource.getPopularMovieList()
        dataSource.refresh()
    }
    @IBAction func topRatedButtonDidTap(_ sender: Any) {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: url.topRated, movieSearchBar: searchMovie)
        dataSource.getTopRatedMovieList()
        dataSource.refresh()
    }
    
    @IBAction func nowPlayingButtonDidTap(_ sender: Any) {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: url.nowPlaying, movieSearchBar: searchMovie)
        configureViewModel()
        dataSource.refresh()
        
    }
    
    private func configureViewModel() {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: url.nowPlaying, movieSearchBar: searchMovie)
    }
    
    @objc private func didPullToRefresh(){
        print("start refresh")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.moviesTableView.refreshControl?.endRefreshing()
            self.moviesTableView.reloadData()
        }
    }

}
