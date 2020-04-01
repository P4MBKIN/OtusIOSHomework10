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

    typealias JobComplition = (job: () -> Void, complition: (TimeInterval) -> Void)
    
    private var jobs: [JobComplition] = []
    
    var count: Int { get { return jobs.count } }
    
    mutating func add(job: @escaping () -> Void, complition: @escaping (TimeInterval) -> Void) { jobs.insert((job, complition), at: 0) }
}

extension JobQueue: IteratorProtocol, Sequence {
    mutating func next() -> JobComplition? { return jobs.popLast() }
}

class JobScheduler {

    private let queue: JobQueue
    private let concurrentQueue: DispatchQueue
    private let semaphore: DispatchSemaphore
    
    init(queue: JobQueue, count: Int, qos: DispatchQoS) {
        self.queue = queue
        self.concurrentQueue = DispatchQueue(label: "jobScheduler.run", qos: qos, attributes: .concurrent)
        self.semaphore = DispatchSemaphore(value: count)
    }
    
    func run() {
        for elem in queue {
            concurrentQueue.async {
                self.semaphore.wait()
                let time = Profiler.runClosureForTime {
                    elem.job()
                }
                self.semaphore.signal()
                DispatchQueue.main.async {
                    elem.complition(time)
                }
            }
        }
    }
}
