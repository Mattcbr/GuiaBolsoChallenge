//
//  CategoriesScreenViewController.swift
//  Chuck Jokes
//
//  Created by Matheus Queiroz on 1/4/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

private let reuseIdentifier = "categoryViewCell"

class CategoriesScreenViewController: UITableViewController, RequestDelegate {

    let requestMaker = Request()
    var categoriesArray: [String]? {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        requestMaker.delegate = self
        requestMaker.requestCategories()
    }

    func didLoadCategories(categories: [String]) {
        self.categoriesArray = categories
    }
    
    func didFailToLoadCategories(withError error: Error) {
        //do nothing for now
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CategoriesCell else {
            fatalError("Not a category cell")
        }
        cell.categoryLabel.text = categoriesArray![indexPath.row]
        
        return cell
    }
}

