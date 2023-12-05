//
//  ConcurrentOperation.swift
//  Lab4
//
//  Created by Admin on 05/12/2023.
//  Copyright © 2023 Admin. All rights reserved.
//

import Foundation


protocol ConcurrentOperation {
    func performTransaction(withdrawAmount: Int, refillAmount: Int)
}
