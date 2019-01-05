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

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let requestMaker = Request()
    var categoriesArray: [String]? {
        didSet{
            self.tableView.reloadData()
            loadingIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        
        requestMaker.delegate = self
        requestMaker.requestCategories()
    }

    //MARK: Request Delegate
    func didLoadCategories(categories: [String]) {
        self.categoriesArray = categories
    }
    
    func didFailToLoadCategories(withError error: Error) {
        //do nothing for now
    }
    
    //MARK: Table View Settings
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
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var selectedCategory = "Random"
        if(segue.identifier != "randomJokeSegue") {
            let selectedCell = sender as! CategoriesCell
            let selectedCellIndexPath = self.tableView.indexPath(for: selectedCell)
            
            selectedCategory = categoriesArray![selectedCellIndexPath!.row]
        }
        
        print("Selected Category: \(selectedCategory)")
        let destinationViewController = segue.destination as! JokeDetailsViewController
        destinationViewController.category = selectedCategory;
    }
}

