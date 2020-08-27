//
//  ShowButton.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class ShowButton: UIButton {
  convenience init(superview: UIView, constraints: (ShowButton) -> ()) {
    self.init()
    if #available(iOS 13.0, *) {
      self.setImage(UIImage(systemName: "arrowtriangle.right.square.fill"), for: .normal)
      self.imageView?.contentMode     = .scaleAspectFill
      self.contentVerticalAlignment   = .fill
      self.contentHorizontalAlignment = .fill
      self.imageEdgeInsets            = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    } else {
      self.setTitle("Show", for: .normal)
      self.setTitleColor(.white, for: .normal)
      self.layer.backgroundColor = UIColor.green.cgColor
      self.layer.cornerRadius    = 8
      self.titleLabel?.font      = .systemFont(ofSize: 15, weight: .bold)
    }
    
    self.tintColor = .green
    
    superview.addSubview(self)
    constraints(self)
  }
}
