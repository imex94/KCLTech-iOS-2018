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
    
    private let tubeStationCollectionViewCellCornerRadius: CGFloat = 6.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: TubeLineTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: TubeLineTableViewCell.identifier)
        
        // Dummy data
        stationNameLabel.text = "Temple"
        distanceFromStationLabel.text = "100m"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = true
        layer.cornerRadius = tubeStationCollectionViewCellCornerRadius
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TubeLineTableViewCell.identifier, for: indexPath)
        guard let lineCell = cell as? TubeLineTableViewCell else { return cell }
        
        return lineCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return TubeLineTableViewCell.height
    }
}
