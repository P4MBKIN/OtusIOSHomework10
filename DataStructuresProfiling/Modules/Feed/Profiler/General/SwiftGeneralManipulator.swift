//
//  GeneralManipulator.swift
//  DataStructuresProfiling
//
//  Created by Pavel on 01.04.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

open class SwiftGeneralManipulator: GeneralManipulator {
    
    fileprivate let arrayManipulator: ArrayManipulator = SwiftArrayManipulator()
    fileprivate let dictionaryManipulator: DictionaryManipulator = SwiftDictionaryManipulator()
    fileprivate let setManipulator: SetManipulator = SwiftSetManipulator()
    
    func runCreation1000(times: Int, numberOfThreads: Int, jobCompletions: [CollectionType: (TimeInterval) -> Void], completion: @escaping () -> Void) {
        var jobQueue = JobQueue()
        for (type, completion) in jobCompletions {
            jobQueue.add(job: {return self.everythingCreation(1000, times, type)}, completion: completion)
        }
        let jobScheduler = JobScheduler(queue: jobQueue, count: numberOfThreads, qos: .default, completion: completion)
        jobScheduler.run()
    }
    
    private func everythingCreation(_ size: Int, _ times: Int, _ type: CollectionType) -> TimeInterval {
        var result: TimeInterval = 0
        for _ in 0..<times {
            switch type {
            case .array:
                result += arrayManipulator.setupWithObjectCount(size)
            case .dictionary:
                result += dictionaryManipulator.setupWithEntryCount(size)
            case .set:
                result += setManipulator.setupWithObjectCount(size)
            }
        }
        return result
    }
}
