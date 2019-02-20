//
//  JokeDetailsViewModel.swift
//  Chuck Jokes
//
//  Created by Matheus Queiroz on 1/7/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import UIKit

class JokeDetailsViewModel: RequestDelegate{
    var Joke: Joke?
    var controller: JokeDetailsViewController
    let requestMaker = Request()
    
    init(viewController: JokeDetailsViewController) {
        self.controller = viewController
        requestMaker.delegate = self
    }
    
    func openJokeWebPage(){
        UIApplication.shared.openURL(URL(string: Joke!.jokeUrl)!)
    }
    
    func requestJokeForCategory(category: String){
        var requestCategory = category
        if(category != "Random"){
            requestCategory = category.lowercased()
        }
        requestMaker.requestJoke(category: requestCategory)
    }
    
    func didLoadJoke(loadedJoke: Joke) {
        if(!loadedJoke.hasLoadedImage){
            requestMaker.requestImage(imageURL: loadedJoke.thumbnailPath) { (thumbnail) in
                loadedJoke.thumbnail = thumbnail
                loadedJoke.hasLoadedImage = true
                self.Joke = loadedJoke
                self.controller.didLoadJoke()
            }
        } else {
            self.Joke = loadedJoke
            self.controller.didLoadJoke()
        }
    }
    
    func didFailToLoadJoke(withError error: Error) {
        self.controller.showErrorLoadingJokeAlert()
        print("ERROR\nError loading Joke:\n\(error.localizedDescription)")
    }
}
