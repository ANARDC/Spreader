//
//  Reactive.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import RxSwift

struct StartInput {
  let link           : PublishSubject<String>
  let downloadButton : PublishSubject<Void>
  let showButton     : PublishSubject<Void>
  let deleteButton   : PublishSubject<Void>
  let networkAccess  : PublishSubject<Bool>
}

struct StartOutput {
  let result       : PublishSubject<Result<Spreadsheet, RequestError>>
  let availability : PublishSubject<Bool>
}
