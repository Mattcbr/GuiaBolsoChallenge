//
//  JokeCategoriesTests.swift
//  Chuck JokesTests
//
//  Created by Matheus Queiroz on 1/5/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import XCTest
@testable import Chuck_Jokes

class JokeCategoriesTests: XCTestCase {
    
    var testCategoriesViewController: CategoriesScreenViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let categoriesVC: CategoriesScreenViewController = storyboard.instantiateViewController(withIdentifier: "categoriesDetailsViewController") as! CategoriesScreenViewController
        testCategoriesViewController = categoriesVC
        _ = testCategoriesViewController.view
    }
    
    override func tearDown() {
        testCategoriesViewController = nil
    }
    
    func testCategories() {
        
        let testCategoriesArray = ["Pizza", "Fries", "Burger", "Milk Shake", "Ice Cream", "Donut", "Waffle"]
        testCategoriesViewController.viewModel!.categoriesArray = testCategoriesArray
        
        let testIndex = Int.random(in: 0 ..< testCategoriesArray.count)
        let testIndexPath = IndexPath(row: testIndex, section: 0)
        let cell = testCategoriesViewController.tableView.cellForRow(at: testIndexPath) as! CategoriesCell
        
        XCTAssertEqual(cell.categoryLabel.text!, testCategoriesArray[testIndex])
    }
}
