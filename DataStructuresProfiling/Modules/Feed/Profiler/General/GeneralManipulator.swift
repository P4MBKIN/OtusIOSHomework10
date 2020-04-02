//
//  GeneralManipulator.swift
//  DataStructuresProfiling
//
//  Created by Pavel on 01.04.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

protocol GeneralManipulator {
    func runCreation1000(times: Int, numberOfThreads: Int, jobCompletions: [CollectionType: (TimeInterval) -> Void], completion: @escaping () -> Void)
}
