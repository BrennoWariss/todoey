//
//  ViewController.swift
//  todoey
//
//  Created by brenno leite wariss on 25/07/18.
//  Copyright © 2018 brenno wariss. All rights reserved.
//

import UIKit
//import Foundation


class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    print(dataFilePath)
    
//    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        loadItems()
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
       
//        if let item = defaults.array(forKey: "todoList") as? [Item]{
//            self.itemArray = item
//        }

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - TABLEVIEW DATASOURCE METHODS

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        
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
        
        saveItems()
        
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

           self.saveItems()
            
            
            self.tableView.reloadData()
            }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "add item"
            
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
           

        } catch {
            print("error ecode itemArray \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)

            }catch{
                print("error decoding itemarray \(error)")
            }
        }
    }
    
}



