//
//  APIService.swift
//  Nushift_Test
//
//  Created by SREEKANTH on 23/08/24.
//

import Foundation
import UIKit

class APIService {
    
    private var dataTask: URLSessionDataTask?
    private let apiKey = "5e0c6e6e57e1c77d5e012bf1b1f7711c"
    
    func getPopularMoviesAPIResponse(completion: @escaping (Result<MoviesModel, Error>) -> Void) {
        
        let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: popularMoviesURL) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Handle JSON data
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesModel.self, from: data)
                //print("RESPONSE === \(jsonData)")
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } 
            catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func getImageDataFrom(url: URL, completion: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    completion(image)
                }
            }
        }.resume()
    }
    
    
}
