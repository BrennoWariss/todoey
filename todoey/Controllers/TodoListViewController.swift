//
//  ViewController.swift
//  todoey
//
//  Created by brenno leite wariss on 25/07/18.
//  Copyright © 2018 brenno wariss. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        
        let newItem1 = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem1)
        
        if let item = defaults.array(forKey: "todoList") as? [Item]{
            self.itemArray = item
        }

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - TABLEVIEW DATASOURCE METHODS

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        return cell
}
    
    //Mark - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
          itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     //Mark - Add New Itens
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            //whats hapen whe the user click add item once
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "todoList")
            
            self.tableView.reloadData()
            }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "add item"
            
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
}



