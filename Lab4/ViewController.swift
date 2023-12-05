//
//  ViewController.swift
//  Lab4
//
//  Created by Admin on 04/12/2023.
//  Copyright © 2023 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let operation = SemaphoreExample()

      override func viewDidLoad() {
          super.viewDidLoad()
          operation.performTransaction(withdrawAmount: 200, refillAmount: 150)
      }
    
}


