//
//  CollectionViewCell.swift
//  RussianNews
//
//  Created by Яблочко on 19.11.2020.
//  Copyright © 2020 Roman Avdonin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        newsImage.image = nil
    }
}
