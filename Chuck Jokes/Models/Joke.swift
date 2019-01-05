//
//  Joke.swift
//  Chuck Jokes
//
//  Created by Matheus Queiroz on 1/5/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import UIKit

class Joke: NSObject {
    
    let id: String
    let jokeDescription: String
    let thumbnailPath: String
    var thumbnail: UIImage
    var hasLoadedImage: Bool
    let jokeUrl : String
    
    init(id: String, desc: String, thumbPath: String, jokeUrl: String) {
        self.id = id
        self.jokeDescription = desc
        self.thumbnailPath = thumbPath
        self.thumbnail = UIImage(named: "chucknorris_logo_coloured_small")!
        self.hasLoadedImage = false
        self.jokeUrl = jokeUrl
    }
}
