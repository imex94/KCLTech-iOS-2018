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
    
    var model: DataModel?
    var currentStation: Station?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: TubeLineTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: TubeLineTableViewCell.identifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = true
        layer.cornerRadius = tubeStationCollectionViewCellCornerRadius
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func configure(model: DataModel?, at indexPath: IndexPath) {
        
        self.model = model
        
        currentStation = model?.stations[indexPath.item]
        stationNameLabel.text = currentStation?.readableStationName
        distanceFromStationLabel.text = currentStation?.readableDistance
        
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let stationId = currentStation?.stationNaptan {
            
            return model?.numberOfTubes(for: stationId) ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TubeLineTableViewCell.identifier, for: indexPath)
        guard let lineCell = cell as? TubeLineTableViewCell else { return cell }
        
        if let stationId = currentStation?.stationNaptan, let tube = model?.getTubes(for: stationId)[indexPath.row] {
            
            lineCell.configure(tube: tube)
        }
        
        return lineCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return TubeLineTableViewCell.height
    }
}
