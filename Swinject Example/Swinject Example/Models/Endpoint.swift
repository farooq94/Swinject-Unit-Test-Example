//
//  Endpoint.swift
//  Swinject Example
//
//  Created by Farooq Rasheed on 28/01/2020.
//  Copyright © 2020 Farooq Rasheed. All rights reserved.
//

protocol Endpoint {
  var path: String { get }
}

enum Coinbase {
  case bitcoin
}

extension Coinbase: Endpoint {
  var path: String {
    switch self {
    case .bitcoin: return "https://api.coinbase.com/v2/prices/BTC-USD/spot"
    }
  }
}
