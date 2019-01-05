//
//  Request.swift
//  Chuck Jokes
//
//  Created by Matheus Queiroz on 1/4/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestDelegate: class{
    func didLoadCategories(categories:[String] )
    func didFailToLoadCategories(withError error: Error)
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
                self.delegate?.didLoadCategories(categories: categoriesArray)
                print(response)
            case .failure(let error):
                self.delegate?.didFailToLoadCategories(withError: error)
                print(error)
            }
        }
    }
}
