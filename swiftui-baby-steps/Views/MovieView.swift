//
//  MovieView.swift
//  swiftui-baby-steps
//
//  Created by Ege Seçkin on 4.01.2025.
//

import SwiftUI

struct MovieSection: View {
	let title: String
	let movies: [Movie]
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(title)
				.font(.title2)
				.fontWeight(.bold)
				.padding(.leading)
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 15) {
					ForEach(movies) { movie in
						NavigationLink(destination: MovieDetailView(movie: movie)) {
							MovieCardView(movie: movie)
						}
					}
				}
				.padding(.horizontal)
			}
		}
	}
}
