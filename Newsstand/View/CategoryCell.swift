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
            categoryImage.image = data.image
        }
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = K.headingFont
        title.textAlignment = .center
        return title
    }()
    
    let categoryImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = UIView.ContentMode.scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(stackView)
        setUpStackView()
        stackView.addArrangedSubview(title)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpStackView() {
        stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
}


