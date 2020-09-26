//
//  UITableView.swift
//  Spreader
//
//  Created by Anar on 07.09.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

extension UITableView {
  func dequeueReusableCell(with identifier: String, for indexPath: IndexPath, closure: (UITableViewCell) -> ()) -> UITableViewCell {
    let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    
    closure(cell)
    
    return cell
  }
}
