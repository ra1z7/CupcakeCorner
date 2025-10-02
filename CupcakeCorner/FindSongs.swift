//
//  Notes.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 01/10/2025.
//

import SwiftUI

struct FindSongs: View {
    struct Song: Codable {
        let trackId: Int
        let trackName: String
        let collectionName: String
        let artworkUrl100: String
    }
    
    struct Response: Codable {
        let resultCount: Int
        let results: [Song]
    }
    
    
    
    
    @State private var songs = [Song]()
    @State private var songsCount = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section("Total Songs: \(songsCount)"){
                    ForEach(songs, id: \.trackId) { song in
                        HStack(spacing: 15) {
                            AsyncImage(url: URL(string: song.artworkUrl100)) { songArtwork in
                                songArtwork
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(.rect(cornerRadius: 15))
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading) {
                                Text(song.trackName)
                                    .font(.headline)
                                Text(song.collectionName)
                                    .foregroundStyle(.secondary)
                            }
                            .lineLimit(1)
                        }
                    }
                }
            }
            .navigationTitle("Sajjan Raj Vaidya")
            .task {
                await loadSongs()
            }
        }
    }
    
    func loadSongs() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=sajjan+raj+vaidya&entity=song&limit=200") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (downloadedData, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Response.self, from: downloadedData)
            songs = decodedData.results
            songsCount = decodedData.resultCount
        } catch {
            print("Unable to download data")
        }
    }
}

#Preview {
    FindSongs()
}
