//
//  ViewController.swift
//  Todoey
//
//  Created by Vitaly Badion on 2/26/19.
//  Copyright © 2019 Vitaly Badion. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    var items = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

    }

    //MARK: - TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoImemCell", for: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //#1
//        let done = itemArray[indexPath.row].done
//
//        if done == false {
//            itemArray[indexPath.row].setValue(true, forKey: "done")
//        } else {
//            itemArray[indexPath.row].setValue(false, forKey: "done")
//        }
        
        //#2
        items[indexPath.row].done = !items[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            guard let titleItem = textField.text else { return }
            
            let newItem = Item(context: self.context)
            newItem.title = titleItem
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.items.append(newItem)
            
            self.saveItems()
        }
        
        alert.addAction(action)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Enter new item"
            textField = alertTextField
        }
        
        present(alert, animated: true)
    }
    
    //MARK: - Model Manipulation methods
    
    //Save items in Core Data on our device
    
    fileprivate func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context, ", error)
        }
        
        tableView.reloadData()
    }
    
    //Load items in Core Data on our device
    
    fileprivate func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)

        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            items = try context.fetch(request)
        } catch {
            print("Error fetching data from context, ", error)
        }
        
        tableView.reloadData()
    }
}

//MARK: - Search Bar methods

extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)

        loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
