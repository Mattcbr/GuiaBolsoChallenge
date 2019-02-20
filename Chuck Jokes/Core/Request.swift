//
//  Request.swift
//  Chuck Jokes
//
//  Created by Matheus Queiroz on 1/4/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

@objc protocol RequestDelegate: class{
    @objc optional func didLoadCategories(categories:[String] )
    @objc optional func didFailToLoadCategories(withError error: Error)
    @objc optional func didLoadJoke(loadedJoke: Joke)
    @objc optional func didFailToLoadJoke(withError error: Error)
}

class Request {
    
    weak var delegate: RequestDelegate?
    
    func requestCategories() {
        let requestURL = "https://api.chucknorris.io/jokes/categories"
        
        let responseParser = Parser()
        
        Alamofire.request(requestURL).responseJSON{ response in
            switch response.result{
                
            case .success(let JSON):
                let categoriesArray = responseParser.parseCategories(response: JSON)
                self.delegate?.didLoadCategories!(categories: categoriesArray)
            case .failure(let error):
                self.delegate?.didFailToLoadCategories!(withError: error)
            }
        }
    }
    func requestJoke(category: String) {
        var requestURL = "https://api.chucknorris.io/jokes/random?category=\(category)"
        if(category == "Random") {
            requestURL = "https://api.chucknorris.io/jokes/random"
        }
        let responseParser = Parser()
        
        Alamofire.request(requestURL).responseJSON{ response in
            switch response.result{
                
            case .success(let JSON):
                let parsedJoke = responseParser.parseJoke(response: JSON)
                self.delegate?.didLoadJoke!(loadedJoke: parsedJoke)
            case .failure(let error):
                self.delegate?.didFailToLoadJoke!(withError: error)
            }
        }
    }
    
    func requestImage(imageURL: String, completion: @escaping (_ image: UIImage) -> Void) {
        var returnImage: UIImage? = nil
        Alamofire.request(imageURL).responseImage { response in
            if let image = response.result.value {
                returnImage = image
                completion(returnImage!)
            }
        }
    }
}
