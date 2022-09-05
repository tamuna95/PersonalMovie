//
//  GennreDataSource.swift
//  PersonalMovieApp
//
//  Created by APPLE on 05.09.22.
//

import Foundation
import UIKit

class GenreDataSource : NSObject {
    internal var genreList : [GenreViewModel] = []
    private var movieGenres : [String] = []
    private var genresCollectionView: UICollectionView
    private var genreViewModel: GenreListViewModelProtocol
    var url : String
    init(genresCollectionView : UICollectionView,genreViewModel : GenreListViewModelProtocol,url : String){
        self.genresCollectionView = genresCollectionView
        self.genreViewModel = genreViewModel
        self.url = url
        super.init()
    }
   
    
    func refresh() {
        genreViewModel.getList(url: url, completion: { genre in
            self.genreList.append(contentsOf: genre)
            print(self.genreList.count)
            self.genresCollectionView.reloadData()
        })
    }
    
   
}


