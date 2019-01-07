//
//  JokeDetailsViewTests.swift
//  Chuck JokesTests
//
//  Created by Matheus Queiroz on 1/5/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import XCTest
@testable import Chuck_Jokes

class JokeDetailsViewTests: XCTestCase {
    
    var testDetailsViewController: JokeDetailsViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC: JokeDetailsViewController = storyboard.instantiateViewController(withIdentifier: "JokeDetailsViewController") as! JokeDetailsViewController
        testDetailsViewController = detailsVC
        _ = testDetailsViewController.view
    }
    
    override func tearDown() {
        testDetailsViewController = nil
    }
    
    func testJokeDescription() {
        let testJoke = Joke(id: "test123",
                            desc: "This is not a Joke",
                            thumbPath: "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
                            jokeUrl: "https://api.chucknorris.io")
        
        testJoke.hasLoadedImage = true
        testDetailsViewController.viewModel?.didLoadJoke(loadedJoke: testJoke)
        
        XCTAssertEqual(testDetailsViewController.jokeDescriptionLabel.text!, testJoke.jokeDescription)
    }
    
    func testJokeCategory() {
        
        let testCategory = "Random"
        let fullCategoryText = "Category: \(testCategory)"
        
        testDetailsViewController.category = testCategory
        testDetailsViewController.viewDidLoad()
        
        XCTAssertEqual(testDetailsViewController.jokeCategoryLabel.text!, fullCategoryText)
    }
}
