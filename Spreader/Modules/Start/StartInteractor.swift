//
//  StartInteractor.swift
//  Spreader
//
//  Created by Anar on 23.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import RxSwift

final class StartInteractor: StartInteractorProtocol {
  let networkService : NetworkService
  let dataService    : DataService
  
  var spreadsheet: Spreadsheet? {
    self.dataService.spreadsheet
  }
  
  init(_ networkService: NetworkService, _ dataService: DataService) {
    self.networkService = networkService
    self.dataService    = dataService
  }
  
  func makeNetworkObserver(for subject: PublishSubject<Bool>) {
    self.networkService.makeNetworkObserver(for: subject)
  }
  
  func makeRequest(with link: String) -> Observable<Result<Spreadsheet, RequestError>> {
    let linkComponents = link.split(separator: "/")
    
    guard linkComponents.count >= 5 else { return .just(.failure(RequestError())) }
    
    let id = String(linkComponents[4])
    
    return self.networkService.request(with: id)
  }
  
  func saveSpreadsheetRow(for spreadsheetRow: SpreadsheetRow) {
    self.dataService.saveSpreadsheetRow(for: spreadsheetRow)
  }
  
  func deleteSpreadsheet() {
    self.dataService.deleteSpreadsheet()
  }
}
