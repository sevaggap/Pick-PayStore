//
//  SearchHistoryDBHelper.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-19.
//

import Foundation
import UIKit
import CoreData

class SearchHistoryDBHelper {
   static var searchHistoryDBHelper = SearchHistoryDBHelper()
    
    let context  = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func addSearchTerm(name : String) {
        let search = NSEntityDescription.insertNewObject(forEntityName: "SearchHistory", into: context!) as! SearchHistory
        
        search.text = name
        
        do {
            try context?.save()
            print("search added to core data")
        } catch {
            print("error saving search")
        }
    }

    func getSearchHistory() -> [SearchHistory] {
        
        var history = [SearchHistory]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchHistory")
        
        do {
            history = try context?.fetch(fetchRequest) as! [SearchHistory]
        } catch {
            print("error getting search history")
        }
        
        return history
    }
    
    
    func resetSearchHistory() {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchHistory")

            do {
                let history = try context?.fetch(fetchRequest)
                if history?.count != 0 {
                    for item in history! {
                        context?.delete(item as! SearchHistory)
                    }
                    try context?.save()
                    print("history reset")
                }
            } catch {
                print("error in resetting history")
            }
        }
}

