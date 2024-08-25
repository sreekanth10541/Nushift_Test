//
//  MovieViewModel.swift
//  Nushift_Test
//
//  Created by SREEKANTH on 23/08/24.
//

import Foundation

class MoviesViewModel {
    
    private var apiService = APIService()
    var popularMovies = [Movies]()
    private var database = DataBaseLayer()
    
    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        apiService.getPopularMoviesAPIResponse { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.popularMovies = listOf.results
                self?.database.saveInCoreDataWith(movies: self?.popularMovies ?? [])
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movies {
        return popularMovies[indexPath.row]
    }
    
    // MARK: - Convert date format
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
}
