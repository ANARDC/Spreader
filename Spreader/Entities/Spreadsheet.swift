//
//  Spreadsheet.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import Unrealm

struct Spreadsheet {
  let values: Array<SpreadsheetRow>?
}

struct SpreadsheetRow: Realmable {
  var id = UUID().uuidString
  
  var langFrom  : String?
  var langTo    : String?
  var text      : String?
  var translate : String?
  
  static func primaryKey() -> String? { "id" }
}
