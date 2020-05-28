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
        images.forEach { imageStackView.addArrangedSubview(UIImageView(image: $0)) }
    }
    
    private func judge(isFavorite: Bool) {
        isFavorite ? likeButton.image = UIImage(systemName: "heart.fill") : nil
    }
    
    private func judge(isSuperHost: Bool) {
        !isSuperHost ? badgeLabel.isHidden = true : nil
    }
    
    func configureData(_ accommodation: Accommodation) {
        judge(isFavorite: accommodation.liked)
        judge(isSuperHost: accommodation.superHost)
        infoLabel.text =  "\(accommodation.housingType)" + "\(accommodation.numBedrooms)" + "bedrooms" + "\(accommodation.numBeds)" + "bed"
        pointAverageLabel.text = "\(accommodation.rating)"
        reviewCountLabel.text = "\(accommodation.numReviews)"
        nameLabel.text = "\(accommodation.name)"
    }
}
