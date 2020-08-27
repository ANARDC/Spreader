//
//  LinkTextField.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

final class LinkTextField: UITextField {
  private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
  
  convenience init(superview: UIView, closure: (LinkTextField) -> ()) {
    self.init()
    self.setup()
    superview.addSubview(self)
    closure(self)
  }
  
  private func setup() {
    self.layer.borderColor     = UIColor.green.cgColor
    self.layer.borderWidth     = 3
    self.layer.cornerRadius    = 8
    self.font                  = .systemFont(ofSize: 18)
    self.textColor             = .white
    self.attributedPlaceholder = NSAttributedString(string: "Enter Google spreadsheet link",
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: self.padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: self.padding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: self.padding)
  }
}
