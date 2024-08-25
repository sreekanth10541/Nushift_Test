//
//  DataBaseLayer.swift
//  Nushift_Test
//
//  Created by SREEKANTH on 25/08/24.
//

import Foundation
import CoreData

class DataBaseLayer {
    
    // MARK: - Save data
    func saveInCoreDataWith(movies: [Movies]) {
        _ = movies.map { self.createMovieEntityFrom(movie: $0) }
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    private func createMovieEntityFrom(movie: Movies) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let movieEntity = NSEntityDescription.insertNewObject(forEntityName: "MovieEntity", into: context)
        movieEntity.setValue(movie.title, forKey: "title")
        movieEntity.setValue(movie.release_date, forKey: "release_date")
        movieEntity.setValue(movie.poster_path, forKey: "poster_path")
        movieEntity.setValue(movie.overview, forKey: "overview")
        movieEntity.setValue(movie.vote_average, forKey: "vote_average")
        return movieEntity
    }
    
    // MARK: - Fetch data
    func fetchMovieDataFromDB() -> [Movies] {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        do {
            let result = try context.fetch(fetchRequest)
            if let moviewResult = result as? [NSManagedObject] {
                let movieData = convertManagedObjectToJSONArray(moArray: moviewResult)
                let data = try JSONSerialization.data(withJSONObject: movieData, options: [])
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Movies].self, from: data)
                return jsonData
            }
        }
        catch {
            print("Error")
        }
        return []
    }
    
    func convertManagedObjectToJSONArray(moArray: [NSManagedObject]) -> Any {
        var jsonArray: [[String: Any]] = []
        for item in moArray {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
   
}
