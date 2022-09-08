//
//  SimilarMovieDataSource.swift
//  PersonalMovieApp
//
//  Created by APPLE on 07.09.22.
//

import Foundation
import UIKit
class SimilarMovieDataSource : NSObject  {
    
    private var similarMovieCollectionView : UICollectionView
    private var similarMoviesViewModel: MovieListViewModelProtocol
    var similarMoviesList: [MovieViewModel] = []
    var obj = MovieDetailViewController()
    
    
    init(similarMovieCollectionView: UICollectionView, similarMoviesViewModel: MovieListViewModelProtocol){
        self.similarMovieCollectionView = similarMovieCollectionView
        self.similarMoviesViewModel = similarMoviesViewModel
        super.init()
        setUpDelegates()
    }
    
    private func setUpDelegates() {
        self.similarMovieCollectionView.dataSource = self
        self.similarMovieCollectionView.delegate = self
    }
    
    func refresh(url : String) {
        similarMoviesViewModel.getList(url: url, completion: { movie in
            self.similarMoviesList.append(contentsOf: movie)
            self.similarMovieCollectionView.reloadData()
        })
    }
}
extension SimilarMovieDataSource : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similarMoviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var similarMovie = similarMoviesList[indexPath.row]

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMovieCell", for: indexPath) as? SimilarMovieCell else { return UICollectionViewCell() }
        cell.configure(with: similarMovie)
        return cell
    }
    
    
    
    
}
