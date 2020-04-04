//
//  JobQueue.swift
//  DataStructuresProfiling
//
//  Created by Pavel Antonov on 11.03.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation
import Dispatch

struct JobQueue {

    typealias JobCompletion = (job: () -> TimeInterval, completion: (TimeInterval) -> Void)
    
    private var jobs: [JobCompletion] = []
    
    var count: Int { get { return jobs.count } }
    
    mutating func add(job: @escaping () -> TimeInterval, completion: @escaping (TimeInterval) -> Void) { jobs.insert((job, completion), at: 0) }
}

extension JobQueue: IteratorProtocol, Sequence {
    mutating func next() -> JobCompletion? { return jobs.popLast() }
}

class JobScheduler {

    private let queue: JobQueue
    private let concurrentQueue: DispatchQueue
    private let semaphore: DispatchSemaphore
    private let completion: () -> Void
    
    init(queue: JobQueue, count: Int, qos: DispatchQoS, completion: @escaping () -> Void) {
        self.queue = queue
        self.concurrentQueue = DispatchQueue(label: "jobScheduler.run", qos: qos, attributes: .concurrent)
        self.semaphore = DispatchSemaphore(value: count)
        self.completion = completion
    }
    
    func run() {
        let jobGroup = DispatchGroup()
        for elem in queue {
            self.semaphore.wait()
            concurrentQueue.async(group: jobGroup) {
                let time = elem.job()
                self.semaphore.signal()
                DispatchQueue.main.async {
                    elem.completion(time)
                }
            }
        }
        jobGroup.notify(queue: DispatchQueue.main) {
            self.completion()
        }
    }
}
