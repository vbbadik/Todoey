//
<<<<<<< HEAD
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vitaly Badion on 3/9/19.
=======
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Vitaly Badion on 3/6/19.
>>>>>>> data-save
//  Copyright © 2019 Vitaly Badion. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD

=======
        
>>>>>>> data-save
        loadCategories()
    }

    // MARK: - TableView DataSource methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD

=======
>>>>>>> data-save
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
<<<<<<< HEAD
    
    
    //MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
=======
    //MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
>>>>>>> data-save
        // Подготовка к переходу на ToDoListViewController
        
        //#1
        performSegue(withIdentifier: "goToItems", sender: self)
        
        //#2
        // Если использовать метод tableView.deselectRow(at: indexPath, animated: true), то
        // при передаче sender: self не будет указан номер ячейки таблицы, так как мы его сняли
        // в объявленном методе
        
//        tableView.deselectRow(at: indexPath, animated: true)
<<<<<<< HEAD
//        let category = categories[indexPath.row]
//        performSegue(withIdentifier: "goToItems", sender: category)
    }
    
    //MARK: - Navigation
    
    // Переход на ToDoListViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //#1
        // Номер ячейки из tableView.indexPathForSelectedRow можно получить лишь в том случае, если
        // в методе performSegue(withIdentifier: String, sender: Any?) - sender: self

        let destinationVC = segue.destination as! ToDoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
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
            
            let newCategory = Category(context: self.context)
            newCategory.name = titleCategory
=======
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
>>>>>>> data-save
            
            self.categories.append(newCategory)
            
            self.saveCategory()
        }
        
<<<<<<< HEAD
        alert.addTextField { (field) in
            field.placeholder = "Enter name category"
            textField = field
        }
        
=======
        alert.addTextField { (textFiled) in
            textFiled.placeholder = "Enter new category"
        }
>>>>>>> data-save
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
<<<<<<< HEAD
    
    //MARK: - Model Manipulation methods
    
    //Save items in Core Data on our device
=======
    //MARK: - Data Manipulation methods
    
    //Save category in Core Data on our device
>>>>>>> data-save
    
    func saveCategory() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
<<<<<<< HEAD
    //Load items in Core Data on our device
=======
    //Load category in Core Data on our device
>>>>>>> data-save
    
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
<<<<<<< HEAD

=======
>>>>>>> data-save
}
