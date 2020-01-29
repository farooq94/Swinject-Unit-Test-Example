//
//  PriceResponse.swift
//  Swinject Example
//
//  Created by Farooq Rasheed on 28/01/2020.
//  Copyright © 2020 Farooq Rasheed. All rights reserved.
//

struct PriceResponse: Codable {
  let data: Price
  let warnings: [Error]?
}
