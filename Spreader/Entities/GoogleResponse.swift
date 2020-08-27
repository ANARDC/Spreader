//
//  GoogleResponse.swift
//  Spreader
//
//  Created by Anar on 24.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import Foundation

struct GoogleResponse: Decodable {
  let range          : String
  let majorDimension : String
  let values         : Array<Array<String>>
}
