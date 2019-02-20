//
//  Parser.swift
//  Chuck Jokes
//
//  Created by Matheus Queiroz on 1/4/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation

class Parser {
    func parseCategories(response: Any) -> [String] {
        let JSONresponse = response as? [String]
        var categoriesArray = [String]()
        
        JSONresponse?.forEach { newCategory in
            let capitalizedCategory = newCategory.capitalized
            categoriesArray.append(capitalizedCategory)
        }
        return categoriesArray
    }
    
    func parseJoke(response: Any) -> Joke {
        let JSONresponse = response as! [String : Any]
        
        let iconURL = JSONresponse["icon_url"] as! String
        let id = JSONresponse["id"] as! String
        let jokeURL = JSONresponse["url"] as! String
        let description = JSONresponse["value"] as! String
        
        let joke = Joke(id: id,
                        desc: description,
                        thumbPath: iconURL,
                        jokeUrl: jokeURL)
        
        return joke
    }
}
