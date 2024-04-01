//
//  ObjectStoreDelegate.swift
//  Note
//
//  Created by Даниил Чугуевский on 25.03.2024.
//

import Foundation

protocol ObjectStoreDelegate{
  
  func objectStoreDidChangeValue(_ objectStore: ObjectStore)
  
}
