//
//  SVReactiveBinder.swift
//  Spreader
//
//  Created by Anar on 27.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import RxSwift

class SVReactiveBinder: StartViewReactiveBinder {
  private weak var view      : StartView!
  private weak var presenter : StartViewPresenterProtocol!
  
  private let bag = DisposeBag()
  
  init(view: StartView, presenter: StartViewPresenterProtocol) {
    self.view      = view
    self.presenter = presenter
  }
  
  func bindLinkTextField() {
    self.view.linkTextField?.rx.text
      .compactMap { $0 }
      .subscribe(self.presenter.input.link)
      .disposed(by: self.bag)
  }
  
  func bindDownloadButton() {
    self.view.downloadButton?.rx.tap
      .subscribe(self.presenter.input.downloadButton)
      .disposed(by: self.bag)
  }
  
  func bindMoveButton() {
    self.view.showButton?.rx.tap
      .subscribe(self.presenter.input.showButton)
      .disposed(by: self.bag)
  }
  
  func bindDeleteButton() {
    self.view.deleteButton?.rx.tap
      .subscribe(self.presenter.input.deleteButton)
      .disposed(by: self.bag)
  }
}
