//
//  MovieDetailViewController.swift
//  PersonalMovieApp
//
//  Created by APPLE on 04.09.22.
//

import UIKit
import Cosmos

class MovieDetailViewController: UIViewController {
    
    private var genreViewModel : GenreListViewModelProtocol!
    private var genreManager: MoviesManagerProtocol!
    private var dataSource : GenreDataSource!
    var selectedMovieGenres : [Int] = []
    var genresName :[String] = []
    var movieImdbField = " "
    var movieNameFiled = " "
    var movieOverviewField = " "
    var movieRateField = 0.0
    var movieImageField = " "
    var moviesId : Int = 0

    var videoViewModel : VideoListViewModelProtocol!
    var videoList : [VideoViewModel] = []
    var movieKey : String = " "
    let semaphore = DispatchSemaphore(value: 1)
    let queue = DispatchQueue(label: "firstQueue")
// MARK: - Outlets
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieImdb: UILabel!
    @IBOutlet weak var movieRate: CosmosView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    var similar : SimilarMovieDataSource!
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
            self.semaphore.wait()
            self.getVideoKeyArray(url: Links.baseUrl.rawValue + "\(self.moviesId)/videos")
            
                self.semaphore.signal()
        }
    }
    
    func configure(){
        let videoManager = LoadVideo()
        videoViewModel = VideoListViewModel(with: videoManager)
    }
    @IBAction func videoPlayButtonDidTap(_ sender: Any) {
        
        displayVideoVC()
    }
    
    func getVideoKeyArray(url : String) {
        configure()
        videoViewModel.getVideoList(url: url, completion: {[weak self] video in
            self?.videoList.append(contentsOf: video)
            if let key = self?.videoList.first?.videoKey {
                self?.movieKey = key
                print("MOOVIE KEY \(self?.movieKey)")
            }
            else {
                
                print("Key not found")
            }

        })
    }
    func displayVideoVC (){
        let sb = UIStoryboard(name: "VideoPlayer", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        vc.key = movieKey
        print("movieKey \(movieKey)")
        print("VC KEY \(vc.key)")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
        
    }
    private func configureViewModel() {
        genreManager = GenresManager()
        genreViewModel = GenreListViewModel(with: genreManager)
        dataSource = GenreDataSource(genresCollectionView: genreCollectionView, genreViewModel: genreViewModel, url: Links.genreUrl.rawValue)
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
//MARK: - View Controller extension

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


