//
//  Note.swift
//  Note
//
//  Created by Даниил Чугуевский on 21.03.2024.
//

import Foundation
import RealmSwift

final class Note: Object {
  
    @Persisted (primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var isDone: Bool
    @Persisted var deadlineDate: Date?
  
  convenience init(name: String, isDone: Bool, deadlineDate: Date? = nil) {
    self.init()
    self.name = name
    self.isDone = isDone
    self.deadlineDate = deadlineDate
    self.id = incrementaID()
  
  }
  
  func incrementaID() -> Int {
      let realm = try! Realm()
      if let lastId = realm.objects(Note.self).sorted(byKeyPath: "id", ascending: false).first?.id {
          return lastId + 1
      }else{
          return 1
      }
  }
  
}

