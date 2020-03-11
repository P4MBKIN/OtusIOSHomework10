//
//  JobQueue.swift
//  DataStructuresProfiling
//
//  Created by Pavel Antonov on 11.03.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

struct Job {
    let job: () -> Void
}

struct JobQueue {
    private var jobs: [Job]
    
    mutating func add(job: Job) { jobs.insert(job, at: 0) }
    
    mutating func pop() -> Job? { return jobs.popLast() }
    
    func size() -> Int { return jobs.count }
}
