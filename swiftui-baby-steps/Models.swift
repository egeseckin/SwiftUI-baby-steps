//
//  Models.swift
//  swiftui-baby-steps
//
//  Created by Ege Seçkin on 4.04.2024.
//

import Foundation

// MARK: - Models
struct Movie: Identifiable, Codable {
	let id: Int
	let title: String
	let overview: String
	let posterPath: String?
	let backdropPath: String?
	let voteAverage: Double
	let releaseDate: String
	
	enum CodingKeys: String, CodingKey {
		case id, title, overview
		case posterPath = "poster_path"
		case backdropPath = "backdrop_path"
		case voteAverage = "vote_average"
		case releaseDate = "release_date"
	}
	
	var posterURL: URL? {
		guard let posterPath = posterPath else { return nil }
		return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
	}
	
	var backdropURL: URL? {
		guard let backdropPath = backdropPath else { return nil }
		return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")
	}
}

struct MovieResponse: Codable {
	let results: [Movie]
}

struct MovieDetail: Codable {
	let runtime: Int?
	let genres: [Genre]
	let credits: Credits
	
	struct Genre: Codable {
		let name: String
	}
	
	struct Credits: Codable {
		let cast: [Cast]
		let crew: [Crew]
	}
	
	struct Cast: Codable {
		let name: String
		let character: String
	}
	
	struct Crew: Codable {
		let name: String
		let job: String
	}
}
