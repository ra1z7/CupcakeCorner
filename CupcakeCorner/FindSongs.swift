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
            .task { // We can't use the standard .onAppear() modifier because it's not designed for async functions.
                // Rather than forcing our entire progress to stop while the networking happens, Swift gives us the ability to say “this work will take some time, so please wait for it to complete while the rest of the app carries on running as usual.”
                // This ability to leave some code running while our main app code carries on working – is called an asynchronous function.
                await loadSongs() // Think of await as being like try – we’re saying we understand a sleep might happen, in the same way try says we acknowledge an error might be thrown.
                //  It literally means "pause the execution of this code right here, let the rest of the app do its thing, and resume here when loadSongs() has finished its work."
            }
        }
    }
    
    func loadSongs() async { // async: This keyword marks the function as asynchronous. It's a signal to Swift that this function might "pause" (go to sleep) to wait for something slow to finish.
        // Creating the URL we want to read.
        guard let url = URL(string: "https://itunes.apple.com/search?term=sajjan+raj+vaidya&entity=song&limit=200") else {
            print("Invalid URL")
            return
        }
        
        do {
            // Fetching the data for that URL.
            // This is where our sleep is likely to happen. I say “likely” because it might not – iOS will do a little caching of data, so if the URL is fetched twice back to back then the data will get sent back immediately rather than triggering a sleep.
            let (downloadedData, _) = try await URLSession.shared.data(from: url) // This is Apple's built-in method for fetching data from a URL. It's an async function itself, because networking takes time. It can also fail (e.g., no internet connection), so it can throw an error.
            // The function returns two things (a tuple): the actual Data object and metadata about the response.
            
            // Decoding the result of that data into a Response struct.
            let decodedData = try JSONDecoder().decode(Response.self, from: downloadedData)
            songs = decodedData.results
            songsCount = decodedData.resultCount
        } catch {
            print("Unable to download data")
        }
    }
}

/*
 Synchronous: Imagine asking a friend a question and staring at them, unable to do anything else until they answer. This is "synchronous." If a network request was synchronous, your entire app would freeze while it waited for the server to respond.

 Asynchronous: Imagine sending a text message to a friend. You send it, then put your phone away and do other things. You get a notification when they reply. This is "asynchronous." The app can continue running, and the code will resume when the data is ready.
 */

#Preview {
    FindSongs()
}
