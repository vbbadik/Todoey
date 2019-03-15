//
//  SwipeViewController.swift
//  Todoey
//
//  Created by Vitaly Badion on 3/15/19.
//  Copyright © 2019 Vitaly Badion. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 75
    }
    
    // MARK: - TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    
    
    //MARK: - Swipe Cell Delegate methods

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            
            self.updateModel(at: indexPath)

        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "trash-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        
        return options
    }
    
    // Метод обновления данных при удалении ячейки
    func updateModel(at indexPath: IndexPath) {
        // Update your Data model
    }
}
