//
//  DownloadButton.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class DownloadButton: UIButton {
  convenience init(superview: UIView, constraints: (DownloadButton) -> ()) {
    self.init()
    self.setTitle("Download", for: .normal)
    self.setTitleColor(.white, for: .normal)
    self.titleLabel?.font   = .systemFont(ofSize: 20, weight: .bold)
    self.layer.cornerRadius = 8
    
    superview.addSubview(self)
    constraints(self)
  }
}
