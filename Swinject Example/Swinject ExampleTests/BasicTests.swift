//
//  BasicTests.swift
//  Swinject Example
//
//  Created by Farooq Rasheed on 28/01/2020.
//  Copyright © 2020 Farooq Rasheed. All rights reserved.
//

import XCTest
import Swinject

@testable import Swinject_Example

class BasicTests: XCTestCase {
  
  private let container = Container()
  
  // MARK: - Boilerplate methods
  
  override func setUp() {
    super.setUp()
    // 1
    
    container.register(Currency.self) { _ in .USD }
    container.register(CryptoCurrency.self) { _ in .BTC }
    
    // 2
    container.register(Price.self) { resolver in
      let crypto = resolver.resolve(CryptoCurrency.self)!
      let currency = resolver.resolve(Currency.self)!
      return Price(base: crypto, amount: "999456", currency: currency)
    }
    
    // 3
    container.register(PriceResponse.self) { resolver in
      let price = resolver.resolve(Price.self)!
      return PriceResponse(data: price, warnings: nil)
    }
  }
  
  override func tearDown() {
    super.tearDown()
    container.removeAll()
  }
  
  // MARK: - Tests
  
  func testPriceResponseData() {
    let response = container.resolve(PriceResponse.self)!
    XCTAssertEqual(response.data.amount, "999456")
  }
  
}
