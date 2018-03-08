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
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var height: CGFloat {
        return lineTableViewCellHeight
    }
    
    func configure(tube: Tube?) {
        guard let tube = tube else { return }
        
        lineImageView.image = UIImage(named: tube.lineId)
        lineDescriptionLabel.text = tube.description
        lineDepartureLabel.text = tube.readableTime
    }
}
