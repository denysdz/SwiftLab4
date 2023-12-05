//
//  SemaphoreExample.swift
//  Lab4
//
//  Created by Admin on 05/12/2023.
//  Copyright © 2023 Admin. All rights reserved.
//

import Foundation


class SemaphoreExample: ConcurrentOperation {
    let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 1)
    var accountBalance = 1000


    func withdraw(amount: Int) {
           concurrentQueue.async {
               self.semaphore.wait()
               defer {
                   self.semaphore.signal()
               }
               if self.accountBalance >= amount {
                   Thread.sleep(forTimeInterval: 1)
                   self.accountBalance -= amount
                   print("Withdrawal successful. Remaining balance: \(self.accountBalance)")
               } else {
                   print("Insufficient funds")
               }
           }
       }

    func refillBalance(amount: Int) {
       concurrentQueue.async {
           self.semaphore.wait()
           defer {
               self.semaphore.signal()
           }
           Thread.sleep(forTimeInterval: 1)
           self.accountBalance += amount
           print("Refill successful. Remaining balance: \(self.accountBalance)")
       }
    }
    
    func performTransaction(withdrawAmount: Int, refillAmount: Int) {
        for _ in 1...5 {
            withdraw(amount: withdrawAmount)
            refillBalance(amount: refillAmount)
        }
    }
    
    
}
