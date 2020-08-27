//
//  DeleteButton.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class DeleteButton: UIButton {
  convenience init(superview: UIView, constraints: (DeleteButton) -> ()) {
    self.init()
    self.setTitle("Delete", for: .normal)
    self.setTitleColor(.white, for: .normal)
    self.titleLabel?.font      = .systemFont(ofSize: 20, weight: .bold)
    self.layer.backgroundColor = UIColor.red.cgColor
    self.layer.cornerRadius    = 8
    
    superview.addSubview(self)
    constraints(self)
  }
}
