//
//  ViewController.swift
//  Todo
//
//  Created by STARKS on 7/14/19.
//  Copyright © 2019 STARKS. All rights reserved.
//

import UIKit
import CoreData
class TodoTableViewController: UITableViewController {
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaultPath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
//let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
    
     load_item()
        

//
//        if let items = defaults.array(forKey: "ToDoListArr") as? [Item]
//       {
//            itemList = items
//        }
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
        save_item()
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
               // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let newItem = Item(context: self.context)
                newItem.title = textFeild.text!
                newItem.done = false
                self.itemList.append(newItem)
             self.save_item()
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
    
    func save_item()
    {
        
        do
        {
            try context.save()
        }
        catch
        {
            
            
        }
        
        
        
        
    }
    func load_item()
    {
       
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do
        {
        itemList = try context.fetch(request)
        }
        catch{
            print("\(error)")
        }
    }
    
    
    
    
}
extension TodoTableViewController: UISearchBarDelegate
{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        print(searchBar.text!)
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do
        {
            itemList = try context.fetch(request)
        }
        catch{
            print("\(error)")
        }
        tableView.reloadData()
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text!.count == 0
        {
            load_item()
             tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
        
    }
    
    
    
}

