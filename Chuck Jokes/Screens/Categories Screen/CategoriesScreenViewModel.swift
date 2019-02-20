//
//  CategoriesScreenViewModel.swift
//  Chuck Jokes
//
//  Created by Matheus Queiroz on 1/7/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation

class CategoriesScreenViewModel: RequestDelegate {
    let requestMaker = Request()
    var controller: CategoriesScreenViewController
    var categoriesArray: [String]? {
        didSet{
            self.controller.didLoadCategories()
        }
    }
    
    init(viewController: CategoriesScreenViewController) {
        self.controller = viewController
        requestMaker.delegate = self
    }
    
    func getCategories() {
        requestMaker.requestCategories()
    }
    
    //MARK: Request Delegate
    func didLoadCategories(categories: [String]) {
        self.categoriesArray = categories
        self.categoriesArray?.sort{$0 < $1}
    }
}
