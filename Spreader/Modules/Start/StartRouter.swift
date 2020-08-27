//
//  StartRouter.swift
//  Spreader
//
//  Created by Anar on 23.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

final class StartRouter: StartRouterProtocol {
  func goToSpreadsheetScreen(from startView: StartView, with spreadsheet: Spreadsheet?) {
    let spreadsheetScreen = SpreadsheetViewController(spreadsheet: spreadsheet)
    
    if #available(iOS 13.0, *) {
      startView.present(spreadsheetScreen, animated: true)
    } else {
      startView.navigationController?.pushViewController(spreadsheetScreen, animated: true)
    }
  }
}
