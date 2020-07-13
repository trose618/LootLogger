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
    
    //tableView.rowHeight = UITableView.automaticDimension
    //tableView.estimatedRowHeight = 65
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // If the triggered segue is the "showItem" segue
    switch segue.identifier {
    case "showItem":
      //Figuire out which row was just tapped
      if let row = tableView.indexPathForSelectedRow?.row {
        
        //Get the item associated witht his row and pass it along
        let item = itemStore.allItems[row]
        let detailViewController
          = segue.destination as! DetailViewController
        detailViewController.item = item
      }
    default:
      preconditionFailure("Unexpected segue identifier.")
    }
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
    
    //cell.backgroundColor = item.valueInDollars >= 50 ? UIColor.red : UIColor.green
    
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
  
  @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    
    let newItem = itemStore.createItem()
    
    if let index = itemStore.allItems.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index, section: 0)
      
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
}
