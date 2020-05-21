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
    
    private func add(images: [UIImage]) {
        for image in images {
            imageStackView.addArrangedSubview(UIImageView(image: image))
        }
    }
    
    private func judge(isFavorite: Bool) {
        if isFavorite{
            likeButton.image = UIImage(systemName: "heart.fill")
        }
    }
    
    private func judge(isSuperHost: Bool) {
        if !isSuperHost {
            badgeLabel.isHidden = true
        }
    }
    
    func configureData(_ accommodation: Accommodation) {
        judge(isFavorite: accommodation.isFavorite)
        judge(isSuperHost: accommodation.isSuperHost)
        infoLabel.text =  "\(accommodation.housingType)" + "\(accommodation.numBedrooms)" + "bedrooms" + "\(accommodation.numBeds)" + "bed"
        pointAverageLabel.text = accommodation.rating
        reviewCountLabel.text = "\(accommodation.numReviews)"
        nameLabel.text = "\(accommodation.name)"
         
    }
}
