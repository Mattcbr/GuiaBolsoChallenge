//
//  CategoriesScreenViewController.swift
//  Chuck Jokes
//
//  Created by Matheus Queiroz on 1/4/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

private let reuseIdentifier = "categoryViewCell"

class CategoriesScreenViewController: UITableViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var viewModel: CategoriesScreenViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CategoriesScreenViewModel.init(viewController: self)
        viewModel?.getCategories()
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
    }
    
    func didLoadCategories() {
        self.tableView.reloadData()
        loadingIndicator.stopAnimating()
    }
    
    //MARK: Table View Settings
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.categoriesArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CategoriesCell else {
            fatalError("Not a category cell")
        }
        cell.categoryLabel.text = viewModel!.categoriesArray![indexPath.row]
        
        return cell
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var selectedCategory = "Random"
        if(segue.identifier != "randomJokeSegue") {
            let selectedCell = sender as! CategoriesCell
            let selectedCellIndexPath = self.tableView.indexPath(for: selectedCell)
            
            selectedCategory = viewModel!.categoriesArray![selectedCellIndexPath!.row]
        }
        
        let destinationViewController = segue.destination as! JokeDetailsViewController
        destinationViewController.category = selectedCategory;
    }
}

