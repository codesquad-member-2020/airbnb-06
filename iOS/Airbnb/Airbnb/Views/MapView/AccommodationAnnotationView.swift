//
//  AccommodationAnnotationView.swift
//  Airbnb
//
//  Created by jinie on 2020/06/05.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import MapKit

class AccommodationAnnotationView: MKAnnotationView {
    
    private let label = AccommodationAnnotationLabel()

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        label.text = nil
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? AccommodationAnnotation else { return }
            
        label.text = "$\(Int(annotation.price))"
        setNeedsLayout()
    }
}
