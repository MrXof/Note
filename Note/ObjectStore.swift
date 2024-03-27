//
//  ObjectStore.swift
//  Note
//
//  Created by Даниил Чугуевский on 22.03.2024.
//

import Foundation

final class ObjectStore{
  
  var delegate: ObjectStoreDelegate?
  private(set) var objects : [Note] = []
  
  static let shared = ObjectStore()
  private init(){
    objects.append(.init(id: 0, name: "Купити молоко", isDone: false, deadlineDate: .init()))
  }
  
  func add(note: Note){
    objects.append(note)
    delegate?.objectStoreDidChangeValue(self)
  }
  
  func clearTableViewCell(index: Int){
    objects.remove(at: index)
  }
  
}
