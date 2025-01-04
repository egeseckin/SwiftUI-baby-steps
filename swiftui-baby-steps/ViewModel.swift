//
//  ViewModel.swift
//  swiftui-baby-steps
//
//  Created by Ege Seçkin on 4.04.2024.
//

import Foundation

class MovieViewModel: ObservableObject {
	@Published var trendingMovies: [Movie] = []
	@Published var nowPlayingMovies: [Movie] = []
	@Published var upcomingMovies: [Movie] = []
	@Published var topRatedMovies: [Movie] = []
	@Published var movieDetail: MovieDetail?
	@Published var isLoading = false
	@Published var errorMessage: String?
	
	private let apiKey = "YOUR_TMDB_API_KEY" // TMDB'den alınacak API key
	private let baseURL = "https://api.themoviedb.org/3"
	
	func fetchMovies() {
		fetchMovieCategory(endpoint: "/trending/movie/week", category: \.trendingMovies)
		fetchMovieCategory(endpoint: "/movie/now_playing", category: \.nowPlayingMovies)
		fetchMovieCategory(endpoint: "/movie/upcoming", category: \.upcomingMovies)
		fetchMovieCategory(endpoint: "/movie/top_rated", category: \.topRatedMovies)
	}
	
	private func fetchMovieCategory(endpoint: String, category: ReferenceWritableKeyPath<MovieViewModel, [Movie]>) {
		let urlString = "\(baseURL)\(endpoint)?api_key=\(apiKey)&language=tr-TR"
		guard let url = URL(string: urlString) else { return }
		
		isLoading = true
		URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			DispatchQueue.main.async {
				self?.isLoading = false
				if let error = error {
					self?.errorMessage = error.localizedDescription
					return
				}
				
				guard let data = data else {
					self?.errorMessage = "Veri alınamadı"
					return
				}
				
				do {
					let response = try JSONDecoder().decode(MovieResponse.self, from: data)
					self?[keyPath: category] = response.results
				} catch {
					self?.errorMessage = error.localizedDescription
				}
			}
		}.resume()
	}
	
	func fetchMovieDetail(for movieId: Int, completion: @escaping (MovieDetail?) -> Void) {
		let urlString = "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)&language=tr-TR&append_to_response=credits"
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			DispatchQueue.main.async {
				if let data = data {
					do {
						let detail = try JSONDecoder().decode(MovieDetail.self, from: data)
						completion(detail)
					} catch {
						completion(nil)
					}
				} else {
					completion(nil)
				}
			}
		}.resume()
	}
}
