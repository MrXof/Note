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
    objects.append(.init(id: 1, name: "Помити кота", isDone: false, deadlineDate: .init()))
    objects.append(.init(id: 2, name: "Список продуктів:\n- Молоко 1л.\n- Хліб\n- Ковбаса\n- Сир\n- Яйця 10 шт.\n- Кола 2л.\n- Серветки", isDone: false, deadlineDate: .init()))
  }
  
  func add(note: Note){
    objects.append(note)
    delegate?.objectStoreDidChangeValue(self)
  }
  
  func clearTableViewCell(index: Int){
    objects.remove(at: index)
  }
  
  func edit(index: Int, note: Note){
    objects[index] = note
    delegate?.objectStoreDidChangeValue(self)
  }
  
}
