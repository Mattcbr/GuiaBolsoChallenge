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
    
    var viewModel: JokeDetailsViewModel?
    var category: String = ""
    
    override func viewDidLoad() {
        self.navigationItem.title = "\(category) Joke"
        
        viewModel = JokeDetailsViewModel.init(viewController: self)
        viewModel!.requestJokeForCategory(category: self.category)
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        jokeDescriptionLabel.text = "Loading..."
        jokeCategoryLabel.text = "Category: \(category)"
        jokeCategoryLabel.isHidden = true;
        jokeWebPageButton.isHidden = true
    }
    
    func didLoadJoke() {
        jokeDescriptionLabel.text = viewModel!.Joke!.jokeDescription
        jokeImageView.image = viewModel!.Joke!.thumbnail
        jokeCategoryLabel.isHidden = false
        jokeWebPageButton.isHidden = false
        loadingIndicator.stopAnimating()
    }
    
    @IBAction func didPressJokeWebPageButton(_ sender: Any) {
        viewModel!.openJokeWebPage()
    }
    
    @IBAction func showErrorLoadingJokeAlert(){
        let alert = UIAlertController(title: "Error", message: "Error retrieving your \(category) joke :/", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Back", comment: "Default action"), style: .default, handler: { _ in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
