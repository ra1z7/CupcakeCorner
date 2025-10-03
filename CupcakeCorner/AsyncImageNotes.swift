//
//  AsyncImageNotes.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 03/10/2025.
//

import SwiftUI

// SwiftUI’s 'Image' view works great with images in your app bundle, but if you want to load a remote image from the internet you need to use 'AsyncImage' instead. This is because downloading can take time, might fail, and SwiftUI doesn't know the image's size until it's downloaded.

/*
 Think of 'Image' as pulling a picture from a photo album you already own. You know exactly what it looks like and how big it is.

 'AsyncImage' is like ordering a poster online. You give it the website address (URL), and it handles the rest: ordering (downloading), saving a copy for later (caching), and putting it on the wall (displaying).
 */

struct AsyncImageNotes: View {
    var body: some View {
        /*
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"))
        //  If I were to include above 1200px image in my project, I’d actually name it logo@3x.png, then also add an 800px image that was logo@2x.png. SwiftUI would then take care of loading the correct image for us, and making sure it appeared nice and sharp, and at the correct size too. However, here, SwiftUI knows nothing about the image until our code is run and the image is downloaded, and so it isn’t able to size it appropriately ahead of time. To fix this, we can tell SwiftUI ahead of time that we’re trying to load a 3x scale image, like this:
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
         */
        
        
        
        
        /*
        // What if we want a precise size? We might try something like this:
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"))
            .frame(width: 200, height: 200) // but as you know, it wouldn’t work with a regular Image either, so you might try to make it .resizable(), but that will make things even worse
        //  Here, we’re actually applying modifiers to a wrapper around the image, which is the AsyncImage view. That will ultimately contain our finished image, but it will also contain a placeholder that gets used while the image is loading. You can actually see the placeholder just briefly when your app runs – that 200x200 gray square is it, and it will automatically go away once loading finishes.
         
         // You can't resize the poster while it's still in the mail. You're trying to resize the box, but the box doesn't know what to do with a .resizable() command.
         */
        
        
        
        
        /*
        //  To adjust our image, we need to use a more advanced form of 'AsyncImage' that passes us the final image view once it’s ready, which we can then customize as needed. As a bonus, this also gives us a second closure to customize the placeholder as needed. For example, we could make the finished image view be both resizable and scaled to fit, and use Color.red as the placeholder so it’s more obvious while you’re learning:
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { downloadedImage in
            downloadedImage
                .resizable()
                .scaledToFit()
        } placeholder: {
            Color.red // we can replace it with ProgressView() – which will display a little spinner activity indicator instead of a solid color.
        }
        .frame(width: 200, height: 200) // A resizable image and Color.red both automatically take up all available space, which means the frame() modifier actually works now.
         */
        
        
        
        
        //  If you want complete control over your remote image, there’s a third way of creating AsyncImage that tells us whether the image was loaded, hit an error, or hasn’t finished yet. This is particularly useful for times when you want to show a dedicated view when the download fails – if the URL doesn’t exist, or the user was offline, etc.
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { imageDownloadingPhase in
            if let successfullyDownloadedImage = imageDownloadingPhase.image {
                successfullyDownloadedImage
                    .resizable()
                    .scaledToFit()
            } else if imageDownloadingPhase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    AsyncImageNotes()
}
