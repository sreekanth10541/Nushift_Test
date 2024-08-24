//
//  MoviesModel.swift
//  Nushift_Test
//
//  Created by SREEKANTH on 23/08/24.
//

import Foundation

struct MoviesModel: Codable {
    let page: Int?
    let results: [Movies]
}

struct Movies: Codable {
    let title: String?
    let release_date: String?
    let poster_path: String?
    let overview: String?
    let vote_average: Double?
}

