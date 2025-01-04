//
//  ContentView.swift
//  swiftui-baby-steps
//
//  Created by Ege Seçkin on 4.04.2024.
//

import SwiftUI

// MARK: - Views
struct ContentView: View {
	@StateObject private var viewModel = MovieViewModel()
	
	var body: some View {
		TabView {
			HomeView()
				.environmentObject(viewModel)
				.tabItem {
					Label("Ana Sayfa", systemImage: "house.fill")
				}
			
//			SearchView()
//				.environmentObject(viewModel)
//				.tabItem {
//					Label("Ara", systemImage: "magnifyingglass")
//				}
		}
		.onAppear {
			viewModel.fetchMovies()
		}
	}
}

@main
struct swiftui_baby_stepsApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
	ContentView()
		  .previewDevice("iPhone 16 Pro")
		  .preferredColorScheme(.dark)
  }
}

#Preview {
	ContentView()
}
