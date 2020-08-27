//
//  StartViewUIFactory.swift
//  Spreader
//
//  Created by Anar on 25.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import SnapKit

class StartViewUIFactory: StartUI {
  private weak var view: StartView!
  
  init(view: StartView) {
    self.view = view
  }
  
  func makeLogoImageView() {
    self.view.logoImageView = LogoImageView(superview: self.view.view) { imageView in
      imageView.snp.makeConstraints { maker in
        maker.top.equalToSuperview().offset(100)
        maker.centerX.equalToSuperview()
        maker.height.equalTo(120)
        maker.width.equalTo(imageView.snp.height).multipliedBy(imageView.frame.size.height / imageView.frame.size.width)
      }
    }
  }
  
  func makeLinkTextField() {
    self.view.linkTextField = LinkTextField(superview: self.view.view) { textField in
      textField.snp.makeConstraints { maker in
        maker.height.equalTo(50)
        maker.left.equalToSuperview().offset(30)
        maker.right.equalToSuperview().offset(-30)
        maker.center.equalToSuperview()
      }
    }
  }
  
  func makeShowButton() {
    self.view.showButton = ShowButton(superview: self.view.view) { button in
      button.snp.makeConstraints { maker in
        guard let linkTextField = self.view.linkTextField else { return }
        
        if #available(iOS 13.0, *) {
          maker.right.equalTo(linkTextField).offset(3)
          maker.top.equalTo(linkTextField.snp.bottom).offset(5)
          maker.height.width.equalTo(56)
        } else {
          maker.right.equalTo(linkTextField)
          maker.top.equalTo(linkTextField.snp.bottom).offset(8)
          maker.height.width.equalTo(50)
        }
      }
    }
  }
  
  func makeDownloadButton() {
    self.view.downloadButton = DownloadButton(superview: self.view.view) { button in
      button.snp.makeConstraints { maker in
        guard let linkTextField = self.view.linkTextField, let moveButton = self.view.showButton else { return }
        
        maker.top.equalTo(linkTextField.snp.bottom).offset(8)
        maker.right.equalTo(moveButton.snp.left).offset(-5)
        maker.left.equalTo(linkTextField)
        maker.height.equalTo(50)
      }
    }
  }
  
  func makeDeleteButton() {
    self.view.deleteButton = DeleteButton(superview: self.view.view) { button in
      button.snp.makeConstraints { maker in
        maker.height.equalTo(50)
        maker.centerX.equalToSuperview()
        maker.left.equalToSuperview().offset(30)
        maker.right.bottom.equalToSuperview().offset(-30)
      }
    }
  }
  
  func toggleDownloadButton(to state: Bool) {
    self.view.downloadButton?.isEnabled = state
    self.view.downloadButton?.backgroundColor = state ? .green : .yellow
  }
}
