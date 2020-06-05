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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pageControl.currentPage = 0
        badgeLabel.text = nil
        infoLabel.text = nil
        pointAverageLabel.text = nil
        reviewCountLabel.text = nil
        nameLabel.text = nil
        bookmarkButton.isSelected = false
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
    
    private func loadImage(urlStrings: [String], to stackView: UIStackView) {
        urlStrings.forEach { url in
            ImageLoader.shared.load(urlString: url) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        guard let image = UIImage(data: data) else { return }
                        let imageView = self.makeImageView(image: image)
                        self.addArrangedSubview(to: stackView, subView: imageView)
                    }
                case .failure(let error):
                    NotificationCenter.default.post(name: .showErrorAlert, object: nil, userInfo: ["error":error])
                }
            }
        }
    }
    
    private func makeImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        return imageView
    }
    
    private func addArrangedSubview(to stackView: UIStackView, subView: UIImageView) {
        let height = self.frame.height / 3
        subView.heightAnchor.constraint(equalToConstant: height).isActive = true
        subView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        stackView.addArrangedSubview(subView)
    }
    
    @inline(__always) private func judge(isFavorite: Bool) {
        isFavorite ? bookmarkButton.isSelected.toggle() : nil
    }
    
    @inline(__always) private func judge(isSuperHost: Bool) {
        !isSuperHost ? badgeLabel.isHidden = true : nil
    }
    
    func configureData(_ accommodation: Accommodation) {
        imageStackView.subviews.forEach { $0.removeFromSuperview() }
        judge(isFavorite: accommodation.isBookmarked)
        judge(isSuperHost: accommodation.isSuperHost)
        infoLabel.text =  "\(accommodation.housingType) " + "\(accommodation.numBedrooms)" + "bedrooms " + "\(accommodation.numBeds)" + "bed"
        pointAverageLabel.text = "\(accommodation.rating)"
        reviewCountLabel.text = "(\(accommodation.numReviews))"
        nameLabel.text = "\(accommodation.name)"
        id = accommodation.id
        loadImage(urlStrings: accommodation.imageUrls, to: self.imageStackView)
    }
}

extension AccommodationSearchCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(scrollView.contentOffset.x / self.contentView.bounds.width))
    }
}
