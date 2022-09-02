//
//  MoviesTableViewCell.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var MovieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configure(with item : MovieViewModel) {
        movieTitleLabel.text = item.title
        imdbLabel.text = "Imdb⭐️ \(item.imdb)"
        releaseDateLabel.text = "Release Date \(item.releaseDate)"
        MovieImageView.imageFromWeb(urlString: "https://image.tmdb.org/t/p/w500\(item.posterPath)", placeHolderImage: UIImage(named: "placeholder.png")!)
    }
}
