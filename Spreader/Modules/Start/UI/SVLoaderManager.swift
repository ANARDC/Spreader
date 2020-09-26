//
//  SVLoaderManager.swift
//  Spreader
//
//  Created by Anar on 27.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class SVLoaderManager: Loader {
  private weak var view: StartView!
  
  init(view: StartView) {
    self.view = view
  }
  
  func start() {
    self.view.loaderView = LoaderView(superview: self.view.view) { view in
      view.indicator.startAnimating()
      
      view.snp.makeConstraints { maker in
        maker.edges.equalToSuperview()
      }
    }
  }
  
  func stop() {        
    self.view.loaderView?.indicator.stopAnimating()
    self.view.loaderView?.removeFromSuperview()
  }
}
