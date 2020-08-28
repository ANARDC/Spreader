//
//  StartProtocols.swift
//  Spreader
//
//  Created by Anar on 23.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit
import Unrealm
import RxSwift

// MARK: View

protocol StartView: UIViewController {
  var presenter: StartViewPresenterProtocol? { get set }
  
  var logoImageView  : LogoImageView? { get set }
  var linkTextField  : LinkTextField? { get set }
  var showButton     : ShowButton? { get set }
  var downloadButton : DownloadButton? { get set }
  var deleteButton   : DeleteButton? { get set }
  var loaderView     : LoaderView? { get set }
}

protocol StartUI {
  func makeLogoImageView()
  func makeLinkTextField()
  func makeShowButton()
  func makeDownloadButton()
  func makeDeleteButton()
  func toggleDownloadButton(to state: Bool)
}

protocol Loader {
  func startLoader()
  func stopLoader()
}

@objc protocol Alert {
  func makeOperationAlert(forState isSuccess: Bool)
  @objc optional func makeDeleteOperationAlert()
}

protocol StartViewReactiveBinder {
  func bindLinkTextField()
  func bindDownloadButton()
  func bindMoveButton()
  func bindDeleteButton()
}

protocol StartViewReactiveProcessor {
  func makeCombinedSubscriber()
  func makeDownloadButtonSubscriber()
  func makeShowButtonSubscriber()
  func makeDeleteButtonSubscriber()
  func makeOutputSubscriber()
  func makeAvailabilitySubscriber()
}


// MARK: Presenter

protocol StartViewPresenterProtocol: StartLifeCyclePresenterProtocol, StartPresenterReactiveProtocol {
  var interactor        : StartInteractorProtocol! { get set }
  var router            : StartRouterProtocol! { get set }
  var uiFactory         : StartUI! { get set }
  var reactiveBinder    : StartViewReactiveBinder! { get set }
  var reactiveProcessor : StartViewReactiveProcessor! { get set }
}

protocol StartLifeCyclePresenterProtocol: class {
  func viewDidLoad()
}

protocol StartPresenterReactiveProtocol {
  var input  : StartInput { get }
  var output : StartOutput { get }
}

// MARK: Interactor

protocol StartInteractorProtocol: class {
  var spreadsheet: Spreadsheet? { get }
  
  func makeNetworkObserver(for subject: PublishSubject<Bool>)
  func makeRequest(with link: String) -> Observable<Result<Spreadsheet, RequestError>>
  func saveSpreadsheetRow(for spreadsheetRow: SpreadsheetRow)
  func deleteSpreadsheet()
}

// MARK: Router

protocol StartRouterProtocol: class {
  func goToSpreadsheetScreen(from startView: StartView, with spreadsheet: Spreadsheet?)
}

// MARK: Configurator

protocol StartConfiguratorProtocol {
  func configure(_ view: StartView)
}
