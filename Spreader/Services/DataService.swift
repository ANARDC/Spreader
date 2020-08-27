//
//  DataService.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import RealmSwift
import Unrealm

class DataService {
  private var realm = try? Realm()
  
  init() {
    print(Realm.Configuration.defaultConfiguration.fileURL ?? "Realm Configuration File Cannot Be Found")
  }
  
  func saveSpreadsheetRow(for entity: SpreadsheetRow) {
    DispatchQueue.main.async {
      try? self.realm?.write {
        self.realm?.add(entity)
      }
    }
  }
  
  func deleteSpreadsheet() {
    DispatchQueue.main.async {
      try? self.realm?.write {
        self.realm?.deleteAll()
      }
    }
  }
  
  var spreadsheet: Spreadsheet? {
    Spreadsheet(values: self.realm?.objects(SpreadsheetRow.self).compactMap { $0 })
  }
}
