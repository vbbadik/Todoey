//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Vitaly Badion on 3/6/19.
//  Copyright © 2019 Vitaly Badion. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    // MARK: - TableView DataSource methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    //MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Подготовка к переходу на ToDoListViewController
        
        //#1
        performSegue(withIdentifier: "goToItems", sender: self)
        
        //#2
        // Если использовать метод tableView.deselectRow(at: indexPath, animated: true), то
        // при передаче sender: self не будет указан номер ячейки таблицы, так как мы его сняли
        // в объявленном методе
        
//        tableView.deselectRow(at: indexPath, animated: true)
//        let selectedIndex = categories[indexPath.row]
//        performSegue(withIdentifier: "goToItems", sender: selectedIndex)
    }
    
    // Переход на ToDoListViewController
    
    //#1
    // Номер ячейки из tableView.indexPathForSelectedRow можно получить лишь в том случае, если
    // в методе performSegue(withIdentifier: String, sender: Any?) - sender: self
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //#2
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "goToItems" {
    //            let destinationVC = segue.destination as! TodoListViewController
    //            destinationVC.selectedCategory = sender as? Category
    //        }
    //    }
    
    //MARK: - Add New Categoies
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = alert.textFields?.first?.text
            
            self.categories.append(newCategory)
            
            self.saveCategory()
        }
        
        alert.addTextField { (textFiled) in
            textFiled.placeholder = "Enter new category"
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    //MARK: - Data Manipulation methods
    
    //Save category in Core Data on our device
    
    func saveCategory() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    //Load category in Core Data on our device
    
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
}
