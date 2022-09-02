//
//  MoviesViewController.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var popularLabel: UIButton!
    @IBOutlet weak var topRatedLabel: UIButton!
    @IBOutlet weak var nowPlayingLabel: UIButton!

    @IBOutlet weak var moviesTableView: UITableView!
    private var viewModel: MovieListViewModelProtocol!
    private var dataSource: MoviesDataSource!
    private var moviesManager: MoviesManagerProtocol!
    private var url = UrlItems()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        dataSource.refresh()
        moviesTableView.refreshControl = UIRefreshControl()
        moviesTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
      

    }
    
    @IBAction func popularButtonDidTap(_ sender: Any) {
        configureMovie()

        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: url.popular)
        dataSource.getPopularMovieList()
        dataSource.refresh()
    }
    @IBAction func topRatedButtonDidTap(_ sender: Any) {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: url.topRated)
        dataSource.getTopRatedMovieList()
        dataSource.refresh()
    }
    
    @IBAction func nowPlayingButtonDidTap(_ sender: Any) {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: url.nowPlaying)
        configureViewModel()
        dataSource.refresh()
        
    }
    private func configureMovie(){
        moviesManager = MoviesManager()
        viewModel = MovieListViewModel(with: moviesManager)
        
    }
    
    private func configureViewModel() {
        configureMovie()
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, urlItems: url.nowPlaying)
    }
    @objc private func didPullToRefresh(){
        print("start refresh")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.moviesTableView.refreshControl?.endRefreshing()
            self.moviesTableView.reloadData()
        }
    }

}
