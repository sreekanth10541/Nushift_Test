//
//  MovieDetailsViewController.swift
//  Nushift_Test
//
//  Created by SREEKANTH on 24/08/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var movieData: Movies?
    private var urlString: String = ""
    private var apiService = APIService()
    private var viewModel = MoviesViewModel()

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var startRatingView: StarRatingView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupNavBar(self)
        if let data = movieData {
            updateUI(title: data.title, releaseDate: data.release_date, overview: data.overview, poster: data.poster_path, rating: data.vote_average ?? 0.0)
        }
        
    }
    
    // Update the UI View
    private func updateUI(title: String?, releaseDate: String?, overview: String?, poster: String?, rating: Double) {
        
        self.movieTitle.text = title
        self.movieRating.text = String(format: "%.2f", rating)
        self.startRatingView.rating = Float(rating/2)
        self.startRatingView.isUserInteractionEnabled = false
        self.overviewLabel.text = overview
        
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.moviePoster.image = nil
        apiService.getImageDataFrom(url: posterImageURL) { image in
            self.moviePoster.image = image
        }
    }

}
