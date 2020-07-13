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
  
  func saveChanges() -> Bool {
    
    let encoder = PropertyListEncoder()
    let data = encoder.encode(allItems)
    
    return false
  }
}
