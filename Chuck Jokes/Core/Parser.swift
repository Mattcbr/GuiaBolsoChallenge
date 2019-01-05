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
            categoriesArray.append(newCategory)
        }
        
        print(categoriesArray)
        
        return categoriesArray
    }
}
