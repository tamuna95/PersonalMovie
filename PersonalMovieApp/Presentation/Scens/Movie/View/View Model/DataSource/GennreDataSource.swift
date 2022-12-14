//
//  GennreDataSource.swift
//  PersonalMovieApp
//
//  Created by APPLE on 05.09.22.
//

import Foundation
import UIKit

class GenreDataSource: NSObject {
    
    internal var genreList: [GenreViewModel] = []
    private var movieGenres: [String] = []
    private var genresCollectionView: UICollectionView
    private var genreViewModel: GenreListViewModel
    internal var genreDict: [Int: String] = [:]
    var url: String
    init(genresCollectionView: UICollectionView, genreViewModel: GenreListViewModel, url: String) {
        self.genresCollectionView = genresCollectionView
        self.genreViewModel = genreViewModel
        self.url = url
        super.init()
    }
    
    func refresh() {
        genreViewModel.getList(
            url: url,
            completion: { [weak self] genre in
                self?.genreList.append(contentsOf: genre)
                print(self?.genreList.count ?? 0)
                if (self?.genreList.isEmpty) == nil {
                    print("Data wasn't fetched")
                } else {
                    for i in self?.genreList ?? [] {
                        self?.genreDict[i.id] = i.name
                    }
                }
                print(self?.genreDict ?? [1: ""])
                self?.genresCollectionView.reloadData()
            })
    }
    
}

