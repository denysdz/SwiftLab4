//
//  OperationQueueExample.swift
//  Lab4
//
//  Created by Admin on 05/12/2023.
//  Copyright © 2023 Admin. All rights reserved.
//


import Foundation

class OperationQueueExample: ConcurrentOperation{

    let operationQueue = OperationQueue()
    let operationQueueLock = NSLock()

    var accountBalance = 1000

    func withdraw(amount: Int) {
        operationQueueLock.lock()
        defer {
            operationQueueLock.unlock()
        }

        if self.accountBalance >= amount {
            Thread.sleep(forTimeInterval: 1)
            self.accountBalance -= amount
            print("Withdrawal successful. Remaining balance: \(self.accountBalance)")
        } else {
            print("Insufficient funds")
        }
    }

    func refillBalance(amount: Int) {
        operationQueueLock.lock()
        defer {
            operationQueueLock.unlock()
        }

        Thread.sleep(forTimeInterval: 1)
        self.accountBalance += amount
        print("Refill successful. Remaining balance: \(self.accountBalance)")
    }
    
    func performTransaction(withdrawAmount: Int, refillAmount: Int) {
        for _ in 1...5 {
            let withdrawOperation = BlockOperation {
                self.withdraw(amount: withdrawAmount)
            }
            operationQueue.addOperation(withdrawOperation)

            let refillOperation = BlockOperation {
                self.refillBalance(amount: refillAmount)
            }
            operationQueue.addOperation(refillOperation)
        }
        operationQueue.waitUntilAllOperationsAreFinished()
        print("All transactions completed. Remaining balance: \(self.accountBalance)")
    }

    
}
