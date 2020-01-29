//
//  BitcoinViewController.swift
//  Swinject Example
//
//  Created by Farooq Rasheed on 28/01/2020.
//  Copyright © 2020 Farooq Rasheed. All rights reserved.
//

import UIKit

class BitcoinViewController: UIViewController {
  
  @IBOutlet weak private var checkAgain: UIButton!
  @IBOutlet weak private var primary: UILabel!
  @IBOutlet weak private var partial: UILabel!
  let fetcher = BitcoinPriceFetcher(networking: HTTPNetworking())

  private let dollarsDisplayFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 0
    formatter.numberStyle = .currency
    formatter.currencySymbol = ""
    formatter.currencyGroupingSeparator = ","
    return formatter
  }()
  
  private let standardFormatter = NumberFormatter()
  
  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    requestPrice()
  }

  // MARK: - Actions
  @IBAction private func checkAgainTapped(sender: UIButton) {
    requestPrice()
  }
  
  // MARK: - Private methods
  private func updateLabel(price: Price) {
    guard let dollars = price.components().dollars,
          let cents = price.components().cents,
          let dollarAmount = standardFormatter.number(from: dollars) else { return }
    
    primary.text = dollarsDisplayFormatter.string(from: dollarAmount)
    partial.text = ".\(cents)"
  }
  
  private func requestPrice() {
    fetcher.fetch { response in
      guard let response = response else { return }

      DispatchQueue.main.async { [weak self] in
        self?.updateLabel(price: response.data)
      }
    }
  }
}


