//
//  MovieDetailViewController.swift
//  PersonalMovieApp
//
//  Created by APPLE on 04.09.22.
//

import UIKit
import Cosmos

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var similarMovieCollectionView: UICollectionView!
    private var genreViewModel : GenreListViewModel!
    private var genreManager: TaskManagerProtocol!
    private var dataSource : GenreDataSource!
    private var similarviewModel: MovieListViewModel!
    private var similarMoviedataSource: SimilarMovieDataSource!
    private var moviesManager: TaskManagerProtocol!
    
    var selectedMovieGenres : [Int] = []
    var genresName :[String] = []
    var movieImdbField = " "
    var movieNameFiled = " "
    var movieOverviewField = " "
    var movieRateField = 0.0
    var movieImageField = " "
    var moviesId : Int = 0

    var videoViewModel : VideoListViewModel!
    var videoList : [VideoViewModel] = []
    var movieKey : String = " "
    let queue = DispatchQueue(label: "firstQueue")
    // MARK: - Outlets
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieImdb: UILabel!
    @IBOutlet weak var movieRate: CosmosView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    //MARK: - SetUp
    
    override func viewDidLoad() {
        configureViewModel()
        print("print",moviesId)
        super.viewDidLoad()
        movieImdb.text = movieImdbField
        movieName.text = movieNameFiled
        movieOverview.text = movieOverviewField
        movieRate.rating = movieRateField
        movieImage.imageFromWeb(urlString: "https://image.tmdb.org/t/p/w500\(movieImageField)", placeHolderImage: UIImage(named: "placeholder.png")!)
        
        queue.async {
            self.getVideoKeyArray(url: Links.baseUrl.rawValue + "\(self.moviesId)/videos")
            
    }
    }
    @IBAction func videoPlayButtonDidTap(_ sender: Any) {
        displayVideoVC()
    }
    
    private func configureViewModel() {
        let videoManager = TaskManager()
        videoViewModel = VideoListViewModel(with: videoManager)
        genreManager = TaskManager()
        genreViewModel = GenreListViewModel(with: genreManager)
        dataSource = GenreDataSource(genresCollectionView: genreCollectionView, genreViewModel: genreViewModel, url: Links.genreUrl.rawValue)
        moviesManager = TaskManager()
        similarviewModel = MovieListViewModel(with: moviesManager)
        dataSource.refresh()
        similarMoviedataSource = SimilarMovieDataSource(similarMovieCollectionView: similarMovieCollectionView, similarMoviesViewModel: similarviewModel)
        similarMoviedataSource.refresh(url: Links.baseUrl.rawValue + "\(moviesId)/similar")
    }


    
    private func getVideoKeyArray(url : String) {
        videoViewModel.getList(url: url, completion: {[weak self] video in
            self?.videoList.append(contentsOf: video)
            if let key = self?.videoList.first?.videoKey {
                self?.movieKey = key
            }
            else {
                
                print("Key not found")
            }
            
        })
    }
    private func displayVideoVC (){
        let sb = UIStoryboard(name: "VideoPlayer", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        vc.key = movieKey
        print("movieKey \(movieKey)")
        print("VC KEY \(vc.key)")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
        
    }
    
    func getGenre(){
        for i in selectedMovieGenres {
            if dataSource.genreDict.keys.contains(i) {
                genresName.append(dataSource.genreDict[i]!)
            }
        }
    }
}
//MARK: - View Controller extension for collection view controller protocol

extension MovieDetailViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        getGenre()
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


