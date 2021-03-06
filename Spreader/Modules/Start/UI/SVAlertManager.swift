//
//  SVAlertManager.swift
//  Spreader
//
//  Created by Anar on 27.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class SVAlertManager: Alert {
  private weak var view: StartView!
  
  init(view: StartView) {
    self.view = view
  }
  
  func makeSaveOperationAlert(forState isSuccess: Bool) {
    let alert = UIAlertController(title: isSuccess ? "Operation Completed Successfully" : "Oops.. Something Went Wrong \n 🥴", message: isSuccess ? "🙌" : "Check the link and try again", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: isSuccess ? "👏" : "Try", style: .default, handler: nil))
    self.view.present(alert, animated: true, completion: nil)
  }
  
  func makeDeleteOperationAlert() {
    let alert = UIAlertController(title: "Success", message: "Your spreadsheet was deleted", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "🤝", style: .default, handler: nil))
    self.view.present(alert, animated: true, completion: nil)
  }
}
