//
//  ObjectStore.swift
//  Note
//
//  Created by Даниил Чугуевский on 22.03.2024.
//

import Foundation
import RealmSwift

final class ObjectStore {
  
  var objects: [Note]{
    get {
      realm.objects(Note.self).map({$0})
    }
  }
  let realm = try! Realm()
  var delegate: ObjectStoreDelegate?
  
  static let shared = ObjectStore()
  private init() {}
  
  func add(note: Note) {
    try! realm.write {
      realm.add(note)
    }
    delegate?.objectStoreDidChangeValue(self)
  }
  
  func removeNote(at index: Int) {
    let arrayNote = realm.objects(Note.self)
    let deleteNote = arrayNote[index]
    try! realm.write {
      realm.delete(deleteNote)
    }
  }
  
  //  func edit(note: Note) {
  //    let arrayNote = realm.objects(Note.self)
  //    let noteUpdate = arrayNote
  //    try! realm.write {
  //      noteUpdate.deadlineDate = note.deadlineDate
  //      noteUpdate.name = note.name
  //    }
  //    delegate?.objectStoreDidChangeValue(self)
  //  }
  
  func edit(block: ()->()) {
    try! realm.write{
      block()
    }
  }
  
}


