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
    @IBOutlet weak var latestMovieOverview: UILabel!
    @IBOutlet weak var latestMovieTitle: UILabel!
    @IBOutlet weak var latestMovieimageView: UIImageView!
    @IBOutlet weak var searchMovie: UISearchBar!
    @IBOutlet weak var popularLabel: UIButton!
    @IBOutlet weak var topRatedLabel: UIButton!
    @IBOutlet weak var nowPlayingLabel: UIButton!
    @IBOutlet weak var moviesTableView: UITableView!
    
    //   MARK: - Components
    private var searchBar : UISearchBar!
    private var viewModel: MovieListViewModel!
    private var dataSource: MoviesDataSource!
    private var moviesManager: TaskManagerProtocol!
    private var searchBarDelegate : UISearchResultsUpdating!
    var latestMovie : GetLatestMovie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesManager = TaskManager()
        viewModel = MovieListViewModel(with: moviesManager)
        latestMovie = GetLatestMovie(with: moviesManager)
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, movieSearchBar: searchMovie,latestMovie : latestMovie)
        designButton()
        dataSource.refresh(url: Links.baseUrl.rawValue + "now_playing",movieSearchBar: searchMovie)
        fetchLatestMovie(url: Links.baseUrl.rawValue + "latest")

        dataSource.passingDataDelegate = self
    }
    func fetchLatestMovie(url : String) {
        latestMovie.getList(url: url, completion: { [weak self] movie in
            self?.latestMovieTitle.text = movie.title
            print("PRINT",self?.latestMovieTitle.text!)
            if movie.posterPath == nil && self?.latestMovieOverview.text != " "{
                self?.latestMovieimageView.isHidden = true
                self?.latestMovieOverview.text = movie.overview
//                self?.latestMovieOverview.isHidden = false
            }
            else {
                self?.latestMovieimageView.imageFromWeb(urlString: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
                self?.latestMovieOverview.isHidden = true

            }
            
        })
                            
    }
    func designButton(){
        popularLabel.layer.cornerRadius = 10
        nowPlayingLabel.layer.cornerRadius = 10
        topRatedLabel.layer.cornerRadius = 10
    }
    func buttonDidTap(button : UIButton){
        button.isSelected = !button.isSelected
       
    }

    //    MARK: - Action Buttons
    @IBAction func popularButtonDidTap(_ sender: Any) {
        print("PRINT",dataSource.moviesList[0].title)
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, movieSearchBar: searchMovie,latestMovie : latestMovie)
        dataSource.passingDataDelegate = self
        dataSource.refresh(url: Links.baseUrl.rawValue + "popular",movieSearchBar: searchMovie)
        
    }
    @IBAction func topRatedButtonDidTap(_ sender: Any) {
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, movieSearchBar: searchMovie,latestMovie : latestMovie)
        dataSource.passingDataDelegate = self
        dataSource.refresh(url: Links.baseUrl.rawValue + "top_rated",movieSearchBar: searchMovie)

    }
    
    @IBAction func nowPlayingButtonDidTap(_ sender: Any) {
        dataSource = MoviesDataSource(moviesTableView: moviesTableView, moviesViewModel: viewModel, movieSearchBar: searchMovie,latestMovie : latestMovie)
        dataSource.passingDataDelegate = self
        dataSource.refresh(url: Links.baseUrl.rawValue + "now_playing",movieSearchBar: searchMovie)
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
