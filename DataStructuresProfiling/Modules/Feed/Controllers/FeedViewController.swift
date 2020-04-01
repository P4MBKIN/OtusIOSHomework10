//
//  FeedViewController.swift
//  OTUS
//
//  Created by Дмитрий Матвеенко on 01/06/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let feedData = Services.feedProvider.feedMockData()
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerNib = UINib.init(nibName: "MyHeaderView", bundle: Bundle.main)
        feedTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "MyHeaderView")
    }
}

extension FeedViewController: UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseID, for: indexPath) as? FeedTableViewCell
        guard let feedCell = cell else { return UITableViewCell() }
        
        feedCell.updateCell(name: feedData[indexPath.row].name)
        return feedCell
    }
}

extension FeedViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var vc: UIViewController?
        
        if let currentCell = tableView.cellForRow(at: indexPath) as? FeedTableViewCell, let name = currentCell.nameLabel.text {
            switch name {
            case "Array":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "ArrayViewController")
            case "Set":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "SetViewController")
            case "Dictionary":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "DictionaryViewController")
            default:
                let storyboard = UIStoryboard(name: "Feed", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "SessionSummaryViewController")
            }
        }
        
        if let pushViewController = vc {
            self.navigationController?.pushViewController(pushViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyHeaderView") as! MyHeaderView
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 115
    }
}

extension FeedViewController: MyHeaderDelegate {
    
    func runTests(numberOfTests: Int, numberOfThreads: Int, completion: () -> Void) {
        // TODO
        completion()
    }
}
