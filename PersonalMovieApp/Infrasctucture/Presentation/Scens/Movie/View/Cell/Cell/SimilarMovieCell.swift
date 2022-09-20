//
//  SimilarMovieCell.swift
//  PersonalMovieApp
//
//  Created by APPLE on 07.09.22.
//

import UIKit

class SimilarMovieCell: UICollectionViewCell {
    @IBOutlet weak var similarMovieImage: UIImageView!
    func configure(with item : MovieViewModel) {
        
        if item.posterPath == "" {
            similarMovieImage.image = UIImage(named: "placeholder.png")
        }
        else {
            similarMovieImage.imageFromWeb(urlString: "https://image.tmdb.org/t/p/w500\(item.posterPath)")
        }
    }
}
