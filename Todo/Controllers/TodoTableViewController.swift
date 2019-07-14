//
//  ViewController.swift
//  Todo
//
//  Created by STARKS on 7/14/19.
//  Copyright © 2019 STARKS. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {
let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
       

     
        


        if let items = defaults.array(forKey: "ToDoListArr") as? [Item]
       {
            itemList = items
        }
   }
    var itemList = [Item]()
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
     let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = itemList[indexPath.row].title
        if itemList[indexPath.row].done == true
        {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return itemList.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
   
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "" , preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textFeild.text != ""
            {
                let newItem = Item()
                newItem.title = textFeild.text!
                self.itemList.append(newItem)
                self.defaults.set(self.itemList, forKey: "ToDoListArr") 
                self.tableView.reloadData()
                
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textFeild = alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true)
    }
    
    
}

