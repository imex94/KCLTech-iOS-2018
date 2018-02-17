//
//  TubeLineTableViewCell.swift
//  ExMap
//
//  Created by Alex Telek on 07/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import UIKit

class TubeLineTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var lineImageView: UIImageView!
    @IBOutlet private weak var lineDescriptionLabel: UILabel!
    @IBOutlet private weak var lineDepartureLabel: UILabel!
    
    private static let lineTableViewCellHeight: CGFloat = 25.0
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Dummy data
        lineImageView.image = UIImage(named: "District")
        lineDescriptionLabel.text = "Westbound - Ealing Broadway"
        lineDepartureLabel.text = "1 min"
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var height: CGFloat {
        return lineTableViewCellHeight
    }
}
