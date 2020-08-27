//
//  LogoImageView.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class LogoImageView: UIImageView {
  convenience init(superview: UIView, constraints: (LogoImageView) -> ()) {
    self.init(image: UIImage(named: "GoogleSheetsLogo"))
    self.contentMode = .scaleAspectFill
    superview.addSubview(self)
    constraints(self)
  }
}
