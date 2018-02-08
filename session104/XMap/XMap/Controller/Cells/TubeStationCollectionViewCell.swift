//
//  TubeStationCollectionViewCell.swift
//  ExMap
//
//  Created by Alex Telek on 07/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import UIKit

class TubeStationCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var stationNameLabel: UILabel!
    @IBOutlet private weak var distanceFromStationLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // MARK: - TODO
        return UITableViewCell()
    }
}
