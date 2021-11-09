//
//  Scheduler.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

final class Scheduler {
    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    static let mainScheduler = DispatchQueue.main

}
