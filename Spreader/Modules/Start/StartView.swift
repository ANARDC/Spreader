//
//  StartView.swift
//  Spreader
//
//  Created by Anar on 23.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController, StartView {
  var configurator : StartConfiguratorProtocol?
  var presenter    : StartViewPresenterProtocol?
  
  var logoImageView  : LogoImageView?
  var linkTextField  : LinkTextField?
  var showButton     : ShowButton?
  var downloadButton : DownloadButton?
  var deleteButton   : DeleteButton?
  var loaderView     : LoaderView?
}

extension StartViewController {
  convenience init(configurator: StartConfiguratorProtocol) {
    self.init()
    self.configurator = configurator
    self.configurator?.configure(self)
  }
  
  override func loadView() {
    super.loadView()
    self.view.layer.backgroundColor = UIColor.darkGray.cgColor
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter?.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
