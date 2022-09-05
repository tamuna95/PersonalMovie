//
//  MovieDetailViewController.swift
//  PersonalMovieApp
//
//  Created by APPLE on 04.09.22.
//

import UIKit
import Cosmos

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieImdb: UILabel!
    @IBOutlet weak var movieRate: CosmosView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    var genreViewModel : GenreListViewModelProtocol!
    private var genreManager: MoviesManagerProtocol!
    
    var dataSource : GenreDataSource!
    var selectedMovieGenres : [Int] = []
    var genresName :[String] = []
    var url = UrlItems()
    var movieImdbField = " "
    var movieNameFiled = " "
    var movieOverviewField = " "
    var movieRateField = 0.0
    var movieImageField = " "
    
    override func viewDidLoad() {
        configureViewModel()
        super.viewDidLoad()
        movieImdb.text = movieImdbField
        movieName.text = movieNameFiled
        movieOverview.text = movieOverviewField
        movieRate.rating = movieRateField
        movieImage.imageFromWeb(urlString: "https://image.tmdb.org/t/p/w500\(movieImageField)", placeHolderImage: UIImage(named: "placeholder.png")!)
    }
    
    private func configureViewModel() {
        genreManager = GenresManager()
        genreViewModel = GenreListViewModel(with: genreManager)
        dataSource = GenreDataSource(genresCollectionView: genreCollectionView, genreViewModel: genreViewModel, url: url.genre)
        dataSource.refresh()

        
    }
    func GetGenresName(){
        for i in dataSource.genreList {
            for j in selectedMovieGenres {
                if j == i.id {
                    genresName.append(i.name)
            }
        }
        }
}
}

extension MovieDetailViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        GetGenresName()
        return genresName .count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as? GenreCell else { return UICollectionViewCell() }
        cell.genreLabel.text = String(genresName[indexPath.row])
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 48)
    }
}


