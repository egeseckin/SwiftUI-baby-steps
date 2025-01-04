//
//  MovieCardView.swift
//  swiftui-baby-steps
//
//  Created by Ege Seçkin on 4.01.2025.
//

import SwiftUI

struct MovieCardView: View {
	let movie: Movie
	
	var body: some View {
		VStack(alignment: .leading) {
			AsyncImage(url: movie.posterURL) { image in
				image
					.resizable()
					.aspectRatio(contentMode: .fill)
			} placeholder: {
				Rectangle()
					.fill(Color.gray.opacity(0.3))
					.overlay(ProgressView())
			}
			.frame(width: 140, height: 200)
			.cornerRadius(10)
			
			Text(movie.title)
				.font(.caption)
				.lineLimit(2)
				.foregroundColor(.primary)
		}
		.frame(width: 140)
	}
}
