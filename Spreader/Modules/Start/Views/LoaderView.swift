//
//  LoaderView.swift
//  Spreader
//
//  Created by Anar on 27.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class LoaderView: UIView {
  var indicator: UIActivityIndicatorView!
  
  convenience init(superview: UIView, constraints: (LoaderView) -> ()) {
    self.init()
    self.layer.backgroundColor = UIColor.gray.withAlphaComponent(0.8).cgColor
    self.makeIndicatorView()
    superview.addSubview(self)
    constraints(self)
  }
  
  private func makeIndicatorView() {
    self.indicator = UIActivityIndicatorView(style: .whiteLarge)
    
    self.addSubview(self.indicator)
    
    self.indicator.snp.makeConstraints { $0.center.equalToSuperview() }
  }
}
