//
//  DispatchQueue.swift
//  Lab4
//
//  Created by Admin on 05/12/2023.
//  Copyright © 2023 Admin. All rights reserved.
//

import Foundation

class DispatchQueueExample : ConcurrentOperation {
    
    let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
    let group = DispatchGroup()

    var accountBalance = 1000

    func withdraw(amount: Int) {
        concurrentQueue.async(group: group) {
            if self.accountBalance >= amount {
                Thread.sleep(forTimeInterval: 1)
                self.accountBalance -= amount
                print("Withdrawal successful. Remaining balance: \(self.accountBalance)")
            } else {
                print("Insufficient funds")
            }
            self.group.leave()
        }
    }

    func refillBalance(amount: Int) {
        concurrentQueue.async(group: group) {
            Thread.sleep(forTimeInterval: 1)
            self.accountBalance += amount
            print("Refill successful. Remaining balance: \(self.accountBalance)")
            self.group.leave()
        }
    }
    
    func performTransaction(withdrawAmount: Int, refillAmount: Int) {
        for _ in 1...5 {
            group.enter()
            withdraw(amount: withdrawAmount)
            group.enter()
            refillBalance(amount: refillAmount)
        }
            group.notify(queue: .main) {
                print("All transactions completed. Remaining balance: \(self.accountBalance)")
        }
    }
    
}
