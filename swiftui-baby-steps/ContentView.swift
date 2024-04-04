//
//  ContentView.swift
//  swiftui-baby-steps
//
//  Created by Ege Seçkin on 4.04.2024.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		NavigationStack {
			VStack {
				Text("Welcome")
				NavigationLink(destination: DetailView()) {
					Text("Navigate To Detail")
				}
			}
			.navigationTitle("Home")
			.navigationBarTitleDisplayMode(.large)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button (action: {
						print("Settings Tapped!")
					}, label: {
						Text("Settings")
					})
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
	ContentView()
		  .previewDevice("iPhone 15 Pro")
		  .preferredColorScheme(.dark)
  }
}

struct DetailView: View {
	var body: some View {
		VStack {
			Image("kodeco")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 150, height: 150)
				.clipShape(.circle)
				.overlay(Circle().stroke(Color.white, lineWidth: 3))
				.shadow(radius: 7)
			Text("Welcome to the Kodeco SwiftUI cookbook!")
				.font(.headline)
			Button(action: {
				print("Button Tapped!")
			}, label: {
				Text("Tap me!")
					.font(.title)
					.foregroundColor(.white)
			})
			.padding()
			.background(
				LinearGradient(
					gradient: Gradient(
						colors: [Color.blue, Color.green]),
						startPoint: .topLeading,
						endPoint: .bottomTrailing)
			)
			.cornerRadius(10)
		}
	}
}
