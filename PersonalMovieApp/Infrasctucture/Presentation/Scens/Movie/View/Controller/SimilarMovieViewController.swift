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
//    private var movieID : MoviesDataSource!
//    
//     init(movieID : MoviesDataSource) {
//         self.movieID = movieID
//         super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
//        dataSource.refresh(url: Links.baseUrl.rawValue + "\(movieID)" + "similar")
        dataSource.refresh(url: Links.baseUrl.rawValue + "now_playing")
        
//        let size = NSCollectionLayoutSize(
//            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
//            heightDimension: NSCollectionLayoutDimension.absolute(250)
//        )
//
//        let item = NSCollectionLayoutItem(layoutSize: size)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 10,
//                                                    leading: 15,
//                                                    bottom: 10,
//                                                    trailing: 15)
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 2)
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//        section.interGroupSpacing = 5
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        similarMovieCollectionnView.collectionViewLayout = layout
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
