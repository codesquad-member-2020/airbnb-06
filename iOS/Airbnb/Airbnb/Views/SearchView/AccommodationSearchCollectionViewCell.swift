//
//  AccommodationSearchCollectionViewCell.swift
//  Airbnb
//
//  Created by jinie on 2020/05/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class AccommodationSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var pointAverageLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    private var id = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        configure()
    }
    
    @IBAction func bookmark(_ sender: UIButton) {
        sender.isSelected.toggle()
        NotificationCenter.default.post(name: .bookmark, object: nil, userInfo: ["id":id])
    }
    
    private func configure() {
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.masksToBounds = true

        configureLayer()
    }
    
    private func configureLayer() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
    
    private func add(images: [UIImage]) {
        images.forEach { imageStackView.addArrangedSubview(UIImageView(image: $0)) }
    }
    
    @inline(__always) private func judge(isFavorite: Bool) {
        isFavorite ? bookmarkButton.isSelected.toggle() : nil
    }
    
    @inline(__always) private func judge(isSuperHost: Bool) {
        !isSuperHost ? badgeLabel.isHidden = true : nil
    }
    
    func configureData(_ accommodation: Accommodation) {
        judge(isFavorite: accommodation.isBookmarked)
        judge(isSuperHost: accommodation.isSuperHost)
        infoLabel.text =  "\(accommodation.housingType) " + "\(accommodation.numBedrooms)" + "bedrooms " + "\(accommodation.numBeds)" + "bed"
        pointAverageLabel.text = "\(accommodation.rating)"
        reviewCountLabel.text = "(\(accommodation.numReviews))"
        nameLabel.text = "\(accommodation.name)"
        id = accommodation.id
    }
}

extension AccommodationSearchCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(scrollView.contentOffset.x / self.contentView.bounds.width))
    }
}
