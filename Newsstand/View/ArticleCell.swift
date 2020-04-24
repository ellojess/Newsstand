//
//  ArticleCell.swift
//  Newsstand
//
//  Created by Bo on 4/24/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation
import UIKit

class ArticleCell: UITableViewCell {
    
    var data: Article? {
        didSet {
            guard let data = data else { return }
            title.text = data.title
        }
    }
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = K.titleFont
        title.textAlignment = .center
        title.text = "testing Article"
        return title
    }()
    
}
