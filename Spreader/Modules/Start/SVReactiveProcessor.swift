//
//  SVReactiveProcessor.swift
//  Spreader
//
//  Created by Anar on 25.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import RxSwift

class SVReactiveProcessor: StartViewReactiveProcessor {
  var uiFactory     : StartUI?
  var loaderManager : Loader?
  var alertManager  : Alert?
  
  private weak var view      : StartView!
  private weak var presenter : StartViewPresenterProtocol!
  
  private let bag = DisposeBag()
  
  init(view: StartView, presenter: StartViewPresenterProtocol) {
    self.view      = view
    self.presenter = presenter
  }
  
  func makeCombinedSubscriber() {
    Observable
      .combineLatest(self.presenter.input.link, self.presenter.input.networkAccess)
      .subscribe(onNext: { link, networkAccess in
        let regex = try! NSRegularExpression(pattern: "https://docs.google.com/spreadsheets/d/([a-zA-Z0-9-_]+)/edit[#&]gid=([0-9]+)", options: .caseInsensitive)
        let linkIsValid = (regex.firstMatch(in: link, options: [], range: NSRange(location: 0, length: link.count)) != nil)
        
        self.presenter.output.availability.onNext(networkAccess && linkIsValid)
      })
      .disposed(by: self.bag)
  }
  
  func makeDownloadButtonSubscriber() {
    self.presenter.input.downloadButton
      .subscribeOn(MainScheduler.instance)
      .do(onNext: { self.loaderManager?.startLoader() })
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
      .withLatestFrom(self.presenter.input.link)
      .flatMapLatest { self.presenter.interactor.makeRequest(with: $0).materialize() }
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { event in
        switch event {
          case let .next(result):
            self.presenter.output.output.onNext(result)
          default:
            return
        }
      })
      .disposed(by: self.bag)
  }
  
  func makeShowButtonSubscriber() {
    self.presenter.input.showButton
      .subscribe(onNext: {
        self.presenter.router.goToSpreadsheetScreen(from: self.view, with: self.presenter.interactor.spreadsheet)
      })
      .disposed(by: self.bag)
  }
  
  func makeDeleteButtonSubscriber() {
    self.presenter.input.deleteButton
      .subscribe(onNext: {
        self.presenter.interactor.deleteSpreadsheet()
        self.alertManager?.makeDeleteOperationAlert()
      })
      .disposed(by: self.bag)
  }
  
  func makeOutputSubscriber() {
    self.presenter.output.output
      .subscribe(onNext: { result in
        self.loaderManager?.stopLoader()
        switch result {
          case .success(let spreadsheet):
            spreadsheet.values?
              .compactMap { $0 }
              .forEach { row in
                self.presenter.interactor.saveSpreadsheetRow(for: row)
            }
            self.alertManager?.makeOperationAlert(forState: true)
          case .failure:
            self.alertManager?.makeOperationAlert(forState: false)
        }
      })
      .disposed(by: self.bag)
  }
  
  func makeAvailabilitySubscriber() {
    self.presenter.output.availability
      .distinctUntilChanged()
      .subscribe(onNext: { availability in
        self.uiFactory?.toggleDownloadButton(to: availability)
      })
      .disposed(by: self.bag)
  }
}
