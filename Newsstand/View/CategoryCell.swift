//
//  CategoryCell.swift
//  Newsstand
//
//  Created by Bo on 4/23/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation
import UIKit

class CategoryCell: UICollectionViewCell {
    
    var data: Category? {
        didSet {
            guard let data = data else { return }
            title.text = data.title
        }
    }
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = K.headingFont
        title.textAlignment = .center
        title.text = "testing Category"
        return title
    }()
    
}
