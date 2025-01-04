//
//  MovieDetailView.swift
//  swiftui-baby-steps
//
//  Created by Ege Seçkin on 4.01.2025.
//

import SwiftUI

struct MovieDetailView: View {
	let movie: Movie
	@EnvironmentObject var viewModel: MovieViewModel
	@State private var movieDetail: MovieDetail?
	@State private var showFullDescription = false
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				// Backdrop Image
				AsyncImage(url: movie.backdropURL) { image in
					image
						.resizable()
						.aspectRatio(contentMode: .fill)
				} placeholder: {
					Rectangle()
						.fill(Color.gray.opacity(0.3))
						.overlay(ProgressView())
				}
				.frame(height: 300)
				.clipped()
				
				VStack(alignment: .leading, spacing: 15) {
					Text(movie.title)
						.font(.title)
						.fontWeight(.bold)
					
					if let detail = movieDetail {
						// Movie Info
						HStack {
							if let runtime = detail.runtime {
								Text("\(runtime) dakika")
							}
							Text("•")
							Text("⭐ \(String(format: "%.1f", movie.voteAverage))")
							Text("•")
							Text(movie.releaseDate)
						}
						.foregroundColor(.gray)
						
						// Genres
						HStack {
							ForEach(detail.genres, id: \.name) { genre in
								Text(genre.name)
									.padding(.horizontal, 10)
									.padding(.vertical, 5)
									.background(Color.blue.opacity(0.2))
									.cornerRadius(15)
							}
						}
					}
					
					// Description
					VStack(alignment: .leading) {
						Text(movie.overview)
							.lineLimit(showFullDescription ? nil : 3)
						
						Button(action: {
							withAnimation {
								showFullDescription.toggle()
							}
						}) {
							Text(showFullDescription ? "Daha az göster" : "Devamını oku")
								.foregroundColor(.blue)
						}
					}
					
					if let detail = movieDetail {
						// Cast
						VStack(alignment: .leading) {
							Text("Oyuncular")
								.font(.headline)
							ScrollView(.horizontal, showsIndicators: false) {
								HStack {
									ForEach(detail.credits.cast.prefix(10), id: \.name) { actor in
										VStack {
											Text(actor.name)
												.font(.caption)
											Text(actor.character)
												.font(.caption2)
												.foregroundColor(.gray)
										}
										.padding(.horizontal)
									}
								}
							}
						}
						
						// Director
						if let director = detail.credits.crew.first(where: { $0.job == "Director" }) {
							VStack(alignment: .leading) {
								Text("Yönetmen")
									.font(.headline)
								Text(director.name)
							}
						}
					}
				}
				.padding()
			}
		}
		.ignoresSafeArea(edges: .top)
		.navigationBarTitleDisplayMode(.inline)
		.onAppear {
			viewModel.fetchMovieDetail(for: movie.id) { detail in
				self.movieDetail = detail
			}
		}
	}
}
