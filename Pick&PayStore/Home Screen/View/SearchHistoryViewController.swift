//
//  SearchHistoryViewController.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-19.
//

import UIKit

class SearchHistoryViewController: UIViewController {

    @IBOutlet weak var searchHistoryTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(HomeScreenViewController.searchHistory)

    }
    
    
    @IBAction func clearHistory(_ sender: Any) {
        SearchHistoryDBHelper.searchHistoryDBHelper.resetSearchHistory()
        searchHistoryTable.reloadData()
    }
    
}

extension SearchHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HomeScreenViewController.searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchHistoryTableViewCell
        
        cell.searchHistory.text = HomeScreenViewController.searchHistory[indexPath.row].text
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
}
