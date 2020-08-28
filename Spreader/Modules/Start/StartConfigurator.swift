//
//  StartConfigurator.swift
//  Spreader
//
//  Created by Anar on 23.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import RxSwift

final class StartConfigurator: StartConfiguratorProtocol {
  var presenter  : StartViewPresenterProtocol!
  var interactor : StartInteractorProtocol!
  var router     : StartRouterProtocol!
  
  func configure(_ view: StartView) {
    let input = StartInput(link: PublishSubject<String>(),
                           downloadButton: PublishSubject<Void>(),
                           showButton: PublishSubject<Void>(),
                           deleteButton: PublishSubject<Void>(),
                           networkAccess: PublishSubject<Bool>())
    
    let output = StartOutput(output: PublishSubject<Result<Spreadsheet, RequestError>>(),
                             availability: PublishSubject<Bool>())
    
    let startViewUIFactory = StartViewUIFactory(view: view)
    
    self.presenter = StartPresenter(view, startViewUIFactory, input, output)
    
    let reactiveBinder = SVReactiveBinder(view: view, presenter: self.presenter)
    let reactiveProcessor = SVReactiveProcessor(view: view, presenter: self.presenter)
    reactiveProcessor.uiFactory     = startViewUIFactory
    reactiveProcessor.alertManager  = SVAlertManager(view: view)
    reactiveProcessor.loaderManager = SVLoaderManager(view: view)
    
    self.interactor = StartInteractor(NetworkService(), DataService())
    self.router     = StartRouter()
    
    self.presenter.interactor        = self.interactor
    self.presenter.router            = self.router
    self.presenter.reactiveBinder    = reactiveBinder
    self.presenter.reactiveProcessor = reactiveProcessor
    
    view.presenter = self.presenter
  }
}
