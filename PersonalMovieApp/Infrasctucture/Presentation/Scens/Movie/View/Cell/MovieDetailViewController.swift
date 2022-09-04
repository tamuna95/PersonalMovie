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
//    ratinngCosmosView.rating = item.imdb / 2

    var movieImdbField = " "
    var movieNameFiled = " "
    var movieOverviewField = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        movieImdb.text = movieImdbField
        movieName.text = movieNameFiled
        movieOverview.text = movieOverviewField
    }
    

   
}
