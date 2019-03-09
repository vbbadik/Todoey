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
<<<<<<< HEAD
    var items = [Item]()
=======
    
    var itemArray = [Item]()
>>>>>>> data-save
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< HEAD
=======
//        itemArray = [Item(title: "Philips Bulb"),
//                     Item(title: "Xiaomi Power Strip"),
//                     Item(title: "Xiaomi LED USB")]
        
>>>>>>> data-save
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
<<<<<<< HEAD
//            itemArray[indexPath.row].setValue(true, forKey: "done")
//        } else {
=======
//            itemArray[indexPath.row].setValue("Выполнено", forKey: "title")
//            itemArray[indexPath.row].setValue(true, forKey: "done")
//        } else {
//            itemArray[indexPath.row].setValue("Не выполнено", forKey: "title")
>>>>>>> data-save
//            itemArray[indexPath.row].setValue(false, forKey: "done")
//        }
        
        //#2
<<<<<<< HEAD
        items[indexPath.row].done = !items[indexPath.row].done
=======
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
>>>>>>> data-save
        
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
            
<<<<<<< HEAD
            self.items.append(newItem)
            
=======
            self.itemArray.append(newItem)
>>>>>>> data-save
            self.saveItems()
        }
        
        alert.addAction(action)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Enter new item"
            textField = alertTextField
        }
        
        present(alert, animated: true)
    }
    
<<<<<<< HEAD
    //MARK: - Model Manipulation methods
=======
    //MARK: - Model Manipulation Methods
>>>>>>> data-save
    
    //Save items in Core Data on our device
    
    fileprivate func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context, ", error)
        }
<<<<<<< HEAD
        
=======
>>>>>>> data-save
        tableView.reloadData()
    }
    
    //Load items in Core Data on our device
    
<<<<<<< HEAD
    fileprivate func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
=======
    fileprivate func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(),  predicate: NSPredicate? = nil) {
>>>>>>> data-save

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)

        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
<<<<<<< HEAD
            items = try context.fetch(request)
=======
            itemArray = try context.fetch(request)
>>>>>>> data-save
        } catch {
            print("Error fetching data from context, ", error)
        }
        
        tableView.reloadData()
    }
}

//MARK: - Search Bar methods

extension ToDoListViewController: UISearchBarDelegate {
<<<<<<< HEAD
    
=======
>>>>>>> data-save
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
<<<<<<< HEAD
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)

=======
    
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
>>>>>>> data-save
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
<<<<<<< HEAD
=======
    
>>>>>>> data-save
}
