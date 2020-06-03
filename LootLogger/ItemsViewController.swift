//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Def Method on 5/14/20.
//  Copyright © 2020 RoseZyArt. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = 65
  }
  
  
  //TABLE VIEW FUNCTIONS
  
  //setting number of rows
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemStore.allItems.count
  }
  
  
  //specifying the cells from the items in the itemStore
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
    
    let item = itemStore.allItems[indexPath.row]
    
    // Configure the cell with the Item
    cell.nameLabel.text = item.name
    cell.serialNumberLabel.text = item.serialNumber
    cell.valueLabel.text = "$\(item.valueInDollars)"
    
    return cell
  }
  
  
  //deleting an item
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let item = itemStore.allItems[indexPath.row]
      
      itemStore.removeItem(item)
      
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  //moving an item
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  
  //Actions
  
  @IBAction func toggleEditingMode(_ sender: UIButton) {
    
    if isEditing {
      sender.setTitle("Edit", for: .normal)
      
      setEditing(false, animated: true)
    }else {
      sender.setTitle("Done", for: .normal)
      
      setEditing(true, animated: true)
    }
  }
  
  @IBAction func addNewItem(_ sender: UIButton) {
    
    let newItem = itemStore.createItem()
    
    if let index = itemStore.allItems.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index, section: 0)
      
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
  }
}
