//
//  NetworkService.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import RxSwift
import Network

class NetworkService {
  func makeNetworkObserver(for subject: PublishSubject<Bool>) {
    if #available(iOS 12.0, *) {
      let monitor = NWPathMonitor()
      monitor.pathUpdateHandler = { path in
        subject.onNext(path.status == .satisfied)
      }
      monitor.start(queue: DispatchQueue.main)
    } else {
      // Fallback on earlier versions
      subject.onNext(true)
    }
  }
  
  func request(with spreadsheetId: String) -> Observable<Result<Spreadsheet, RequestError>> {
    URLSession
      .shared
      .rx
      .response(request: URLRequest(url: URL(string: "https://sheets.googleapis.com/v4/spreadsheets/\(spreadsheetId)/values/A:D?key=\(apiKey)")!))
      .map { response in
        do {
          return .success(
            Spreadsheet(
              values: try JSONDecoder().decode(GoogleResponse.self, from: response.data)
                .values
                .map {
                  SpreadsheetRow(langFrom: $0[0], langTo: $0[1], text: $0[2], translate: $0[3])
              }
            )
          )
        } catch {
          return .failure(RequestError())
        }
    }
  }
}
