//
//  NewsCell.swift
//  News
//
//  Created by Musa Kokcen on 16.03.2021.
//

import UIKit
import Kingfisher

struct NewsCellModel {
    let imageUrl: String?
    let title: String
    let date: String
}

extension NewsCell {
    struct Constant {
        struct UI {
            static let backgroundColor: UIColor = .white
            static let fallbackImage: UIImage? = UIImage(named: "news")
        }
    }
}

class NewsCell: UITableViewCell {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with data: NewsCellModel) {
        backgroundColor = Constant.UI.backgroundColor
        selectionStyle = .none
        
        newsTitleLabel.text = data.title
        newsTitleLabel.textColor = .black
        newsTitleLabel.isUserInteractionEnabled = false
        
        dateLabel.text = data.date
        dateLabel.textColor = .black
        dateLabel.isUserInteractionEnabled = false
        
        newsImageView.image = Constant.UI.fallbackImage
        newsImageView.contentMode = .scaleAspectFill
        
        if let imageUrl = URL(string: data.imageUrl ?? "") {
            newsImageView.kf.setImage(with: imageUrl, placeholder: nil, options: nil) { [weak self] (result) in
                switch result {
                case .success(let data):
                    self?.newsImageView.image = data.image
                case .failure(_):
                    self?.newsImageView.image = Constant.UI.fallbackImage
                }
            }
        } else {
            newsImageView.image = Constant.UI.fallbackImage
        }
    }
}
