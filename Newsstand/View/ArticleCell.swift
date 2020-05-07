//
//  ArticleCell.swift
//  Newsstand
//
//  Created by Bo on 4/24/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    var articleImage: UIImageView = {
        var articleImage = UIImageView()
        articleImage.layer.cornerRadius = 10
        articleImage.clipsToBounds = true
        return articleImage
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.lineBreakMode = NSLineBreakMode.byWordWrapping
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true

        title.textColor = .black
        title.font = K.titleFont
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        contentView.addSubview(articleImage)
        contentView.addSubview(title)
        setUpStackView()
        setUpImage()
        setUpTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpStackView(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85).isActive = true
        stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75).isActive = true
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func setUpImage() {
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        articleImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        articleImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        articleImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        articleImage.widthAnchor.constraint(equalTo: articleImage.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func getImage(article: Article) {
        if let imageURL = article.urlToImage {
        articleImage.kf.setImage(with: URL(string: imageURL)) { result in
            switch result {
            case .success(let value):
                self.title.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -200).isActive = true
                print(value.image)
                print(value.cacheType)
                print(value.source)
            case .failure(let error):
                self.title.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor).isActive = true
                print(error)
            }
            }
        }
    }
    
    func setUpTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200).isActive = true
        title.heightAnchor.constraint(equalToConstant: 80).isActive = true
        title.trailingAnchor.constraint(equalTo: self.articleImage.leadingAnchor).isActive = true
    }
   
    
}
