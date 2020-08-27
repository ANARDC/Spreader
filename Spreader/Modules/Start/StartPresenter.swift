//
//  StartPresenter.swift
//  Spreader
//
//  Created by Anar on 23.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import RxSwift

final class StartPresenter: StartViewPresenterProtocol {
  weak var view         : StartView!
  var interactor        : StartInteractorProtocol!
  var router            : StartRouterProtocol!
  var uiFactory         : StartUI!
  var reactiveBinder    : StartViewReactiveBinder!
  var reactiveProcessor : StartViewReactiveProcessor!
  
  let input  : StartInput
  let output : StartOutput
  
  let bag = DisposeBag()
  
  init(_ view: StartView, _ uiFactory: StartViewUIFactory, _ input: StartInput, _ output: StartOutput) {
    self.view      = view
    self.uiFactory = uiFactory
    
    self.input  = input
    self.output = output
  }
}

// MARK: - View Life Cycle
extension StartPresenter: StartLifeCyclePresenterProtocol {
  func viewDidLoad() {
    self.makeView()
    self.makeReactive()
    self.bindReactive()
  }
}

private extension StartPresenter {
  func makeView() {
    self.uiFactory.makeLogoImageView()
    self.uiFactory.makeLinkTextField()
    self.uiFactory.makeShowButton()
    self.uiFactory.makeDownloadButton()
    self.uiFactory.makeDeleteButton()
  }
  
  func makeReactive() {
    self.interactor.makeNetworkObserver(for: self.input.networkAccess)
    self.reactiveProcessor.makeCombinedSubscriber()
    self.reactiveProcessor.makeDownloadButtonSubscriber()
    self.reactiveProcessor.makeShowButtonSubscriber()
    self.reactiveProcessor.makeDeleteButtonSubscriber()
    self.reactiveProcessor.makeOutputSubscriber()
    self.reactiveProcessor.makeAvailabilitySubscriber()
  }
  
  func bindReactive() {
    self.reactiveBinder.bindLinkTextField()
    self.reactiveBinder.bindDownloadButton()
    self.reactiveBinder.bindMoveButton()
    self.reactiveBinder.bindDeleteButton()
  }
}
