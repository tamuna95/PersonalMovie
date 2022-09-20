//
//  DetailMovieDataSource.swift
//  PersonalMovieApp
//
//  Created by APPLE on 20.09.22.
//

import Foundation
import UIKit
import Cosmos

class DetailMovieDataSource {
    
    var toggleButton: UIButton
    var movieImdbField : UILabel
    var movieNameFiled :UILabel
    var movieOverviewField : UILabel
//    var movieImageField : UIImageView
    var moviesId : Int
    var movieImageField : String
    var selectedMovieGenres : [Int] = []
    var genresName :[String] = []
    var movieRate: CosmosView
    var likes : Bool {
        get {
            return UserDefaults.standard.bool(forKey: "likes")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "likes")
        }
    }
    private var dataSource : GenreDataSource!

    init(toggleButton: UIButton,movieImdbField : UILabel,movieNameFiled :UILabel,movieOverviewField : UILabel, movieRate: CosmosView,moviesId : Int,movieImageField : String){
        self.toggleButton = toggleButton
        self.movieImdbField = movieImdbField
        self.movieNameFiled = movieNameFiled
        self.movieOverviewField = movieOverviewField
//        self.movieRateField = movieRateField
//        self.movieImageField = movieImageField
        self.movieRate = movieRate
        self.moviesId = moviesId
        self.movieImageField = movieImageField
    }
     func toggleLikeButton(){
        self.toggleButton.isSelected = self.likes
        self.toggleButton.setTitle("Like", for: .normal)
        self.toggleButton.setTitle("Liked", for: .selected)
        self.toggleButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    }
     func disableRating(){
        movieRate.settings.updateOnTouch = false
        
    }
    func getGenre(){
        for i in selectedMovieGenres {
            if dataSource.genreDict.keys.contains(i) {
                genresName.append(dataSource.genreDict[i]!)
            }
        }
    }
}
