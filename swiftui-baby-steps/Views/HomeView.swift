//
//  HomeView.swift
//  swiftui-baby-steps
//
//  Created by Ege Seçkin on 4.01.2025.
//

import SwiftUI

struct HomeView: View {
	@EnvironmentObject var viewModel: MovieViewModel
	
	var body: some View {
		NavigationView {
			ScrollView {
				if viewModel.isLoading {
					ProgressView("Yükleniyor...")
				} else {
					VStack(alignment: .leading, spacing: 20) {
						MovieSection(title: "Trend Filmler", movies: viewModel.trendingMovies)
						MovieSection(title: "Vizyondakiler", movies: viewModel.nowPlayingMovies)
						MovieSection(title: "Yakında", movies: viewModel.upcomingMovies)
						MovieSection(title: "En İyi Filmler", movies: viewModel.topRatedMovies)
					}
				}
			}
			.navigationTitle("Film & Diziler")
			.alert("Hata", isPresented: Binding(
				get: { viewModel.errorMessage != nil },
				set: { if !$0 { viewModel.errorMessage = nil } }
			)) {
				Text(viewModel.errorMessage ?? "")
			}
		}
	}
}
