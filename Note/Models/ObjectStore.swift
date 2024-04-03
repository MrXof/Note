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
  var objectNotificationToken : NotificationToken?

  static let shared = ObjectStore()
  private init() {
    
    let results = realm.objects(Note.self)
    objectNotificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
      guard let self = self else { return }
      
      switch changes{
      case .update(_ , _ , _ , _):
        self.delegate?.objectStoreDidChangeValue(self)
      case .initial(_):
        break
      case .error(_):
        break
      }
      
    }
  }
  
  func add(note: Note) {
    try! realm.write {
      realm.add(note)
    }
  }
  
  func removeNote(at index: Int) {
    let arrayNote = realm.objects(Note.self)
    let deleteNote = arrayNote[index]
    try! realm.write {
      realm.delete(deleteNote)
    }
  }
  
  func edit(block: ()->()) {
    try! realm.write {
      block()
    }
  }
  
}

