//
//  MoviesTableViewCell.swift
//  Nushift_Test
//
//  Created by SREEKANTH on 23/08/24.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var startRatingView: StarRatingView!

    private var urlString: String = ""
    private var apiService = APIService()
    private var viewModel = MoviesViewModel()

    // Setup movies values
    func setCellWithValuesOf(_ movie:Movies) {
        updateUI(title: movie.title, releaseDate: movie.release_date, overview: movie.overview, poster: movie.poster_path, rating: movie.vote_average ?? 0.0)
    }
    
    // Update the UI Views
    private func updateUI(title: String?, releaseDate: String?, overview: String?, poster: String?, rating: Double) {
        
        self.movieTitle.text = title
        
        let releaseDataStr = "Release date: " + viewModel.convertDateFormater(releaseDate)
        
        self.movieYear.text = releaseDataStr
        self.movieRating.text = String(format: "%.2f", rating)
        self.startRatingView.rating = Float(rating/2)
        self.startRatingView.isUserInteractionEnabled = false
        
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
