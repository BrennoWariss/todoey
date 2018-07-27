//
//  ViewController.swift
//  todoey
//
//  Created by brenno leite wariss on 25/07/18.
//  Copyright © 2018 brenno wariss. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = ["find mike", "buy egg", "destroy demon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - TABLEVIEW DATASOURCE METHODS

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
}
    
    //Mark - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     //Mark - Add New Itens
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            //whats hapen whe the user click add item once
            self.itemArray.append(textField.text!)
            
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



