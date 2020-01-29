//
//  AutoregisterTests.swift
//  Swinject Example
//
//  Created by Farooq Rasheed on 28/01/2020.
//  Copyright © 2020 Farooq Rasheed. All rights reserved.
//

import XCTest
import Swinject
import SwinjectAutoregistration

@testable import Swinject_Example

// Autoregister can handle PriceResponse and Price as long as there are no optionals in the initializer.

extension PriceResponse {
  init(data: Price) {
    self.init(data: data, warnings: nil)
  }
}

extension Price {
  init(amount: String) {
    self.init(base: .BTC, amount: amount, currency: .USD)
  }
}

class AutoregisterTests: XCTestCase {
  
  private let container = Container()
  
  // MARK: - Boilerplate methods
  
  override func setUp() {
    super.setUp()
    container.autoregister(Price.self,
                           argument: String.self,
                           initializer: Price.init(amount:))

    container.autoregister(PriceResponse.self,
                           argument: Price.self,
                           initializer: PriceResponse.init(data:))
  }

  
  override func tearDown() {
    super.tearDown()
    container.removeAll()
  }
  
  // MARK: - Tests
  
  func testPriceResponseData() {
    let price = container ~> (Price.self, argument: "789654")
    let response = container ~> (PriceResponse.self, argument: price)
    XCTAssertEqual(response.data.amount, "789654")
  }
  
  
  func testPrice() {
    let price = container ~> (Price.self, argument: "999456")
    XCTAssertEqual(price.amount, "999456")
  }

}
