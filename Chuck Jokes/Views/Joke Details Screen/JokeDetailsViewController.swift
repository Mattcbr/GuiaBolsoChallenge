//
//  JokeDetailsViewController.swift
//  Chuck Jokes
//
//  Created by Matheus Queiroz on 1/5/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import UIKit

class JokeDetailsViewController: UIViewController, RequestDelegate {
    @IBOutlet weak var jokeDescriptionLabel: UILabel!
    @IBOutlet weak var jokeCategoryLabel: UILabel!
    @IBOutlet weak var jokeImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var jokeWebPageButton: UIButton!
    
    let requestMaker = Request()
    var category: String = ""
    var Joke: Joke? {
        didSet{
            jokeDescriptionLabel.text = Joke!.jokeDescription
            if(!Joke!.hasLoadedImage){
                requestMaker.requestImage(imageURL: Joke!.thumbnailPath) { (thumbnail) in
                    self.Joke!.thumbnail = thumbnail
                    self.jokeImageView.image = thumbnail
                    self.Joke!.hasLoadedImage = true
                }
            }
            jokeCategoryLabel.isHidden = false
            jokeWebPageButton.isHidden = false
            loadingIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = "\(category) Joke"
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        jokeDescriptionLabel.text = "Loading..."
        jokeCategoryLabel.text = ""
        jokeCategoryLabel.text = "Category: \(category)"
        jokeCategoryLabel.isHidden = true;
        jokeWebPageButton.isHidden = true
        
        requestMaker.delegate = self
        requestMaker.requestJoke(category: category)
    }
    
    func didLoadJoke(loadedJoke: Joke) {
        self.Joke = loadedJoke
    }
    @IBAction func didPressJokeWebPageButton(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: Joke!.jokeUrl)!)
    }
}
