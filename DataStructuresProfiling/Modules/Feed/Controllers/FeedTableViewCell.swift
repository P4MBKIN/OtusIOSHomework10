//
//  FeedTableViewCell.swift
//  OTUS
//
//  Created by Дмитрий Матвеенко on 16/06/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: FeedTableViewCell.self)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func updateCell(name: String, detail: String = "", detailColor: UIColor = .black) {
        nameLabel.text = name
        detailLabel.text = detail
        detailLabel.backgroundColor = detailColor
    }
}
