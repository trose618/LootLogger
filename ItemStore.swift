//
//  ItemStore.swift
//  LootLogger
//
//  Created by Def Method on 5/14/20.
//  Copyright © 2020 RoseZyArt. All rights reserved.
//

import UIKit

class ItemStore {
  
  var allItems = [Item]()
  
  init() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self,
                                   selector: #selector(saveChanges),
                                   name: UIScene.didEnterBackgroundNotification,
                                   object: nil)
  }
  
//  Using a closure like this allows you to set the value for a variable or constant that requires multiple lines of code, which can be very useful when configuring objects. This makes your code more maintainable because it keeps the property and the code needed to generate the property together.
  let itemArchiveURL: URL = {
    let documentsDirectories =
      FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentsDirectories.first!
    return documentDirectory.appendingPathComponent("items.plist")
  }()
  
  @discardableResult func createItem() -> Item {
    
    let newItem = Item(random: true)
    
    allItems.append(newItem)
    
    return newItem
  }
  
  
  func removeItem(_ item: Item) {
    if let index = allItems.firstIndex(of: item) {
      allItems.remove(at: index)
    }
  }
  
  func moveItem(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex {
      return
    }
    
    let movedItem = allItems[fromIndex]
    
    allItems.remove(at: fromIndex)
    
    allItems.insert(movedItem, at: toIndex)
  }
  
  @objc func saveChanges() -> Bool {
    print("Saving items to \(itemArchiveURL)")
    
    do {
      let encoder = PropertyListEncoder()
      let data = try encoder.encode(allItems)
      try data.write(to: itemArchiveURL, options: [.atomic])
      print("Saved all of the items")
      return true
    } catch let encodingError {
      print("Error encoding allItems: \(encodingError)")
      return false
    }
  }
}
