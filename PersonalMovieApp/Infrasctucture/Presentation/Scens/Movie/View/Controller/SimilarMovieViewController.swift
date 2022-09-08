//
//  SimilarMovieViewController.swift
//  PersonalMovieApp
//
//  Created by APPLE on 07.09.22.
//

import UIKit

class SimilarMovieViewController: UIViewController {
    @IBOutlet weak var similarMovieCollectionnView: UICollectionView!
    private var viewModel: MovieListViewModelProtocol!
    private var dataSource: SimilarMovieDataSource!
    private var moviesManager: MoviesManagerProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
//        dataSource.refresh(url: Links.baseUrl.rawValue + "\(movieID)" + "similar")
        dataSource.refresh(url: Links.baseUrl.rawValue + "now_playing")
        
    }
    private func configureMovie(){
        moviesManager = MoviesManager()
        viewModel = MovieListViewModel(with: moviesManager)
    }
    
    private func configureViewModel() {
        configureMovie()
        dataSource = SimilarMovieDataSource(similarMovieCollectionView: similarMovieCollectionnView, similarMoviesViewModel: viewModel)

}
}
extension SimilarMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 600)
    }
}
