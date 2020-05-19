//
//  AccommodationSearchCollectionViewCell.swift
//  Airbnb
//
//  Created by jinie on 2020/05/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class AccommodationSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var likeButton: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var pointAverageLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
