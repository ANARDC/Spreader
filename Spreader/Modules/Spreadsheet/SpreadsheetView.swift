//
//  SpreadsheetView.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import SnapKit

final class SpreadsheetViewController: UITableViewController {
  var spreadsheet: Spreadsheet?
  
  convenience init(spreadsheet: Spreadsheet?) {
    if #available(iOS 13.0, *) {
      self.init(style: .insetGrouped)
    } else {
      self.init(style: .grouped)
    }
    self.spreadsheet = spreadsheet
  }
  
  override func loadView() {
    super.loadView()
    self.navigationController?.navigationBar.barStyle = .blackTranslucent
    
    self.tableView.backgroundColor = UIColor.gray
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }
}

extension SpreadsheetViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    self.spreadsheet?.values?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    4
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    "\(section + 1) row:"
  }
  
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    if let view = view as? UITableViewHeaderFooterView {
      view.textLabel?.textColor = .white
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell      = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
    let value     = self.spreadsheet?.values?.compactMap { $0 } [indexPath.section]
    let `default` = RequestError().description
    
    let strings = [
      "Language From: \(value?.langFrom ?? `default`)",
      "Language To: \(value?.langTo ?? `default`)",
      "Text: \(value?.text ?? `default`)",
      "Translate: \(value?.translate ?? `default`)"
    ]
    
    cell.textLabel?.text          = strings[indexPath.row]
    cell.backgroundColor          = UIColor.darkGray
    cell.textLabel?.textColor     = .white
    cell.textLabel?.numberOfLines = 0
    cell.isUserInteractionEnabled = false
    
    return cell
  }
}
