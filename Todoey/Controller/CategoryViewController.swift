//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vitaly Badion on 3/9/19.
//  Copyright © 2019 Vitaly Badion. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    var categories: Results<Category>?
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    // MARK: - TableView DataSource methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "Category not added yet"
        
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
//        if let category = categories?[indexPath.row] {
//            performSegue(withIdentifier: "goToItems", sender: category)
//        }
    }
    
    //MARK: - Navigation
    
    // Переход на ToDoListViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //#1
        // Номер ячейки из tableView.indexPathForSelectedRow можно получить лишь в том случае, если
        // в методе performSegue(withIdentifier: String, sender: Any?) - sender: self

        let destinationVC = segue.destination as! ToDoListViewController

        if let indexPath = tableView.indexPathForSelectedRow, let category = categories?[indexPath.row] {
            destinationVC.selectedCategory = category
        }
        
        //#2
//        if segue.identifier == "goToItems" {
//            let destinationVC = segue.destination as! ToDoListViewController
//            destinationVC.selectedCategory = sender as? Category
//        }
    }

    //MARK: - Add new category
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            guard let titleCategory = textField.text else { return }
            
            let newCategory = Category()
            newCategory.name = titleCategory
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (field) in
            field.placeholder = "Enter name category"
            textField = field
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    
    //MARK: - Model Manipulation methods
    
    //Save items in Realm database on our device
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    //Load items from Realm database on our device
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }

}
